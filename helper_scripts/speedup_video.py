"""Wrapper script that uses ffmpeg to identify segments of a video file
where "nothing is happening" (i.e. the terminal output is not moving)
and shortens them to speed up the video.

Example - find all segments where nothing is happening for at least 3
seconds and shorten them to 1 second:

    python speedup_video.py -i in.webm -o out.webm -k 1 -t 3
"""

import argparse
import subprocess


def main():
    args = parse_args()

    if args.verbose:
        print("Finding frozen segments...")

    frozen_segments = get_frozen_segments(args.input, args.sensitivity, args.threshold)

    if args.verbose:
        print("Found the following frozen segments:")
        print(*frozen_segments, sep="\n")

    segments_to_keep = get_segments_to_keep(frozen_segments, args.keep)

    if args.verbose:
        print("Keeping the following segments:")
        print(*segments_to_keep, sep="\n")

    if args.verbose:
        print("Processing video...")

    result = process_video(args.input, args.output, segments_to_keep)

    if args.verbose:
        print("Done, ffmpeg output:")
        print(result)


def parse_args():
    """Parses command line arguments."""

    parser = argparse.ArgumentParser(
        description="Uses ffmpeg to identify segments of video with where frames are identical and shortens their length."
    )
    parser.add_argument("--input", "-i", help="Input video file", required=True)
    parser.add_argument("--output", "-o", help="Output video file", required=True)
    parser.add_argument(
        "--threshold",
        "-t",
        help="Length in seconds of segments to be considered for shortening.",
        type=float,
        default=1,
    )
    parser.add_argument(
        "--keep",
        "-k",
        help="Number of seconds to keep of each shortened segment. Must be less than threshold.",
        type=float,
        default=1,
    )
    parser.add_argument(
        "--sensitivity",
        "-s",
        help="Noise tolerance of ffmpeg's freezedetect filter. See https://ffmpeg.org/ffmpeg-filters.html#freezedetect.",
        type=str,
        default="-60dB",
    )
    parser.add_argument(
        "--verbose", "-v", help="Prints additional information.", action="store_true"
    )

    args = parser.parse_args()

    if args.keep > args.threshold:
        print(
            f"Cannot keep more seconds({args.keep}) than the specified threshold ({args.threshold})."
        )
        exit(1)

    return args


def get_frozen_segments(input, sensitivity, threshold):
    """Returns a list of tuples of the form (start, end) of periods of identical frames in the video."""

    # Run ffmpeg with freezedetect to find video segments of identical/similar frames.
    detect_freeze_cmd = f"ffmpeg -an -nostats -i {input} -vf freezedetect=n={sensitivity}:d={threshold},metadata=mode=print:file=- -map 0:v:0 -f null -"
    detect_freeze_result = subprocess.run(
        detect_freeze_cmd.split(), capture_output=True
    )

    # Need to look for these patterns in freezedetect output:
    match_patterns = [
        "lavfi.freezedetect.freeze_start",
        "lavfi.freezedetect.freeze_end",
    ]

    matching_lines = []
    frozen_segments = []

    for line in detect_freeze_result.stdout.decode().split("\n"):
        if any(pattern in line for pattern in match_patterns):
            matching_lines.append(line)

    # If the first/last frozen segment is at the very beginning/end of the video,
    # the corresponding line will not be present in the output. Adding it here.
    if "freeze_end" in matching_lines[0]:
        matching_lines.insert(0, "lavfi.freezedetect.freeze_start=0")
    if "freeze_start" in matching_lines[-1]:
        # using "end" as a placeholder for the end of the video.
        matching_lines.append(f"lavfi.freezedetect.freeze_end=end")

    # Convert frozen segments into a list of tuples of the form (start, end).
    for i in range(0, len(matching_lines) - 1, 2):
        start = float(matching_lines[i].split("=")[1])
        end = float(matching_lines[i + 1].split("=")[1])
        frozen_segments.append((start, end))

    return frozen_segments


def get_segments_to_keep(frozen_segments, keep_seconds):
    """Takes a list of tuples of "frozen" segments and returns a list of tuples of the form (start, end) of segments to keep."""

    segments_to_keep = []

    segments_to_keep.append((0, frozen_segments[0][0] + keep_seconds))

    for idx, (freeze_start, freeze_end) in enumerate(frozen_segments):
        if idx == len(frozen_segments) - 1:
            # using arbitrary large number as a placeholder for the end of the video.
            segments_to_keep.append((freeze_end, 9999999))
        else:
            segments_to_keep.append(
                (freeze_end, frozen_segments[idx + 1][0] + keep_seconds)
            )

    return segments_to_keep


def process_video(input, output, segments_to_keep):
    """Runs ffmpeg with the required filter to speed up the video."""

    # Construct the expression for the select filter (https://ffmpeg.org/ffmpeg-filters.html#select_002c-aselect)
    select_filter = ""
    for segment in segments_to_keep:
        if select_filter != "":
            select_filter += "+"
        select_filter += f"between(t,{segment[0]},{segment[1]})"

    cmd = f"ffmpeg -y -i {input} -vf select='{select_filter}',setpts=N/FRAME_RATE/TB {output}"

    result = subprocess.run(cmd.split(), capture_output=True)

    # ffmpeg human-readable output goes to stderr, not stdout
    return result.stderr.decode()


if __name__ == "__main__":
    main()

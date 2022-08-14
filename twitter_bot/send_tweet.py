import os
import sys
import tweepy

tweet_file = open(sys.argv[1], "r")
tweet_text = tweet_file.read()

video_file = open(sys.argv[2], "r")

auth = tweepy.OAuth1UserHandler(
    os.environ["TWITTER_API_KEY"],
    os.environ["TWITTER_API_SECRET"],
    os.environ["TWITTER_ACCESS_TOKEN"],
    os.environ["TWITTER_ACCESS_TOKEN_SECRET"],
)

api = tweepy.API(auth)

upload_result = api.media_upload(filename=sys.argv[2], media_category="tweet_video")

print("Video upload result:", upload_result)

if upload_result.processing_info["state"] == "succeeded":
    api.update_status(status=tweet_text, media_ids=[upload_result.media_id])
else:
    api.update_status(status=tweet_text)

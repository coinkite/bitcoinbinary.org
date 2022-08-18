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

# Twitter API v1.1 client - for video upload (v2 doesn't have upload endpoint)
api = tweepy.API(auth)

# Twitter API v2 client - for tweeting (cannot use v1.1 for tweeting with "Essential access" Developer account)
client = tweepy.Client(
    consumer_key=os.environ["TWITTER_API_KEY"],
    consumer_secret=os.environ["TWITTER_API_SECRET"],
    access_token=os.environ["TWITTER_ACCESS_TOKEN"],
    access_token_secret=os.environ["TWITTER_ACCESS_TOKEN_SECRET"],
)

my_screen_name = client.get_me().data.username

upload_result = api.media_upload(filename=sys.argv[2], media_category="tweet_video")
print(f"Video upload result: {upload_result}\n")

if upload_result.processing_info["state"] == "succeeded":
    tweet = client.create_tweet(text=tweet_text, media_ids=[upload_result.media_id])
    print(
        f"Tweeted with video: https://twitter.com/{my_screen_name}/status/{tweet.data['id']}\n"
    )
else:
    tweet = client.create_tweet(text=tweet_text)
    print(
        f"Tweeted without video: https://twitter.com/{my_screen_name}/status/{tweet.data['id']}\n"
    )

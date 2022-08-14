# This script can be used to get the access token and access token secret for the bot.
#
# It's useful when your Twitter Developer account is associated to one account
# but you need to use another account to send the tweets
#
# See: https://docs.tweepy.org/en/stable/authentication.html?#pin-based-oauth

import tweepy

api_key = input("Enter the API key of your Twitter app: ")
api_secret = input("Enter the API secret of your Twitter app: ")

oauth1_user_handler = tweepy.OAuth1UserHandler(api_key, api_secret, callback="oob")

print(
    "Go to the following URL to authorize your app to act as another Twitter account: "
    + oauth1_user_handler.get_authorization_url()
)

verifier = input("Enter verification PIN you got from the authorization page: ")

access_token, access_token_secret = oauth1_user_handler.get_access_token(verifier)

print("Access token: " + access_token)
print("Access token secret: " + access_token_secret)

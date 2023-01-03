from slack_sdk import WebClient
from slack_sdk.http_retry import RetryHandler

def get_client(token):
   retry_handler = RetryHandler(max_retry_count=5)
   return WebClient(token=token, retry_handlers=[retry_handler])

def lambda_handler(request, context):
   # Extract token from the Fivetran request object
   token = request['secrets']['apiKey']

   # Get user objects from Slack
   users = get_users(token=token)

   # Construct and send appropriate JSON response back to Fivetran
   return {
       "state": {},
       "schema" : {
           "users" : {
               "primary_key" : ["id"]
           }
       },
       "insert": {
           "users": users
       },
       "hasMore" : False
   }

def get_users(token):
   client = get_client(token=token)
   response = client.users_list()
   members = response.get('members')
   users = []

   # Extracting only certain user attributes
   for member in members:
       users.append({
           "id": member["id"],
           "team_id": member.get("team_id", ""),
           "name": member.get("name", ""),
           "real_name": member.get("real_name", ""),
           "is_bot": member.get("is_bot", "")
       })

   return users

if __name__ == "__main__":
    print(lambda_handler("", ""))

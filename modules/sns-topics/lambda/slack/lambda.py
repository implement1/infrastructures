"""Lambda function to send slack messages from SNS"""
import json
import os
import urllib3

# Environment Variable
WEBHOOK_URL = os.environ["SLACK_HOOK_URL"]


def send_alert_slack(message):
    """Sends message to slack"""
    try:
        http = urllib3.PoolManager()
        resp = http.request(
            "POST",
            WEBHOOK_URL,
            headers={"Content-Type": "application/json"},
            body=json.dumps(message).encode("utf-8"),
        )
    except Exception as err:
        raise (err) from err


def prepare_message(record):
    """Builds slack message"""
    subject = record["Subject"]
    message = json.loads(record["Message"])
    aws_region = os.environ.get("AWS_REGION")

    alarm_details = "*Alarm Details:*\n"
    alarm_details += f"*Name:* {message['AlarmName']}\n"
    alarm_details += f"*Description:* {message['AlarmDescription']}\n"
    alarm_details += f"*State Change:* {message['OldStateValue']} -> {message['NewStateValue']}\n"
    alarm_details += (
        f"*Reason for State Change:*\n{message['NewStateReason']}\n"
    )
    alarm_details += f"*Timestamp:* {message['StateChangeTime']}\n"
    alarm_details += f"*AWS Account:* {message['AWSAccountId']}\n"
    alarm_details += f"*Alarm ARN:* `{message['AlarmArn']}`\n"

    body = {
        "blocks": [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f"*{subject}*",
                },
            },
            {
                "type": "divider",
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": alarm_details,
                },
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f"*<https://{aws_region}.console.aws.amazon.com/"
                    f"cloudwatch/home?region={aws_region}#alarmsV2:"
                    f"alarm/{message['AlarmName']}?|View CloudWatch Alarm>*",
                },
            },
        ]
    }
    return send_alert_slack(body)


def lambda_handler(event, _):
    """lambda handler"""
    try:
        for record in event["Records"]:
            prepare_message(record["Sns"])
    except Exception as err:
        raise Exception(err) from err

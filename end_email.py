# send_via_gmail_app_password.py
import smtplib
from email.message import EmailMessage
import argparse

def send_email_gmail(sender: str, recipient: str, subject: str, body: str, app_password: str):
    msg = EmailMessage()
    msg["From"] = sender
    msg["To"] = recipient
    msg["Subject"] = subject
    msg.set_content(body)

    # Use Gmail's SMTP with STARTTLS on port 587
    with smtplib.SMTP("smtp.gmail.com", 587) as smtp:
        smtp.ehlo()
        smtp.starttls()
        smtp.ehlo()
        smtp.login(sender, app_password)      # use App Password here
        smtp.send_message(msg)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("language")
    parser.add_argument("paradigm")
    args = parser.parse_args()
    # Replace these with your values
    SENDER = "tiyliu@ucdavis.edu"
    RECIPIENT = "tiyliu@ucdavis.edu"
    RECIPIENT2 = "sagae@ucdavis.edu"
    SUBJECT = f"Training completed for {args.language}_{args.paradigm}"
    BODY = "Training done."
    APP_PASSWORD = ""  # 16-character app password (no spaces when using)

    send_email_gmail(SENDER, RECIPIENT, SUBJECT, BODY, APP_PASSWORD)
    send_email_gmail(SENDER, RECIPIENT2, SUBJECT, BODY, APP_PASSWORD)

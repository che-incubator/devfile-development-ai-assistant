import os
from time import sleep
from openai import OpenAI

client = OpenAI(
    api_key=os.getenv('OPENAI_API_KEY'),
)


def create_thread():
    return client.beta.threads.create()


def delete_thread(thread_id):
    return client.beta.threads.delete(thread_id=thread_id)


def send_message(thread_id, message):
    return client.beta.threads.messages.create(
        thread_id,
        role="user",
        content=message,
    )


def run_assistant(thread_id, assistant_id):
    return client.beta.threads.runs.create(
        thread_id=thread_id, assistant_id=assistant_id
    )


def get_message(thread_id):
    thread_messages = client.beta.threads.messages.list(thread_id)
    return thread_messages.data[0]


def get_run_status(thread_id, run_id):
    return client.beta.threads.runs.retrieve(thread_id=thread_id, run_id=run_id)


def format_message(raw_message):
    if message == "":
        return "Provide initial devfile."

    try:
        yaml = ruamel.yaml.YAML()
        yaml.load(raw_message)
        return """```yaml
        {}
        ```""".format(raw_message)
    except ScannerError:
        return raw_message


def chat(message):
    thread = create_thread()
    send_message(thread.id, format_message(str(message, encoding='utf-8')))
    run = run_assistant(thread.id, os.getenv('ASSISTANT_ID'))
    while run.status != "completed":
        run.status = get_run_status(thread.id, run.id).status
        print("Status:", run.status)
        sleep(1)

    response = get_message(thread.id)
    delete_thread(thread.id)

    return response.content[0].text.value

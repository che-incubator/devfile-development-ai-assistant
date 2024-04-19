# Devfile Development AI Assistant

Welcome to the Devfile Development AI Assistant repository! 
This project uses the OpenAI API to provide an intelligent assistant designed to support 
developers in managing and understanding devfiles effectively.

## Description

The Devfile Development AI Assistant is crafted to enhance the developer experience 
by offering real-time assistance with devfiles. 
By leveraging the capabilities of OpenAI's language models, this assistant can answer complex queries, 
assist in troubleshooting, and suggest best practices related to devfiles.


## ChatGPT

You can use the assistant in [ChatGPT](https://chat.openai.com/g/g-Bm20CP2Rp-devfile-assistant) form.

## Getting Started

### Prerequisites

- Python 3.6 or later
- An active OpenAI API key
- Access to a Kubernetes cluster

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/che-incubator/devfile-development-ai-assistant.git
   ```
2. Navigate to the repository directory:
   ```bash
   cd devfile-development-ai-assistant
   ```
3. Build the application image:
   ```bash
   ./build.sh --image <IMAGE>
   ```
4. Deploy the assistant to your Kubernetes cluster:
   ```bash
   ./deploy.sh --namespace <NAMESPACE> --image <IMAGE> --openai-api-key <OPENAI_API_KEY>
   ```

### Usage

Once deployed, interact with the assistant inside your Kubernetes cluster by accessing service:
   ```bash
   curl -X POST -d '{"message": "Provide a devfile"}'  -H "Content-Type: application/json" http://devfile-assistant.<NAMESPACE>.svc:9000/
   ```

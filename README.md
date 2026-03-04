# API Phishing Checker with AHP

This project retrieves phishing data from free sources (e.g., OpenPhish feed) and uses Analytic Hierarchy Process (AHP) in MATLAB to evaluate and rank phishing URLs based on criteria like URL length, HTTPS presence, and suspicious words.

## Features
- Download and check URLs against phishing feeds.
- Extract features for AHP analysis.
- Rank URLs by risk score using AHP.

## Installation
1. Clone the repo: `git clone https://github.com/waldonhendricks/api-phising.git`
2. For Python: `pip install -r requirements.txt`
3. For MATLAB: Run scripts in MATLAB environment.

## Usage
- Run `python openphish_checker.py` to check a URL.
- Run `ahp_phishing.m` in MATLAB for AHP ranking.

## AHP Hierarchy Graph

```mermaid
graph TD
    A[Evaluate Phishing Risk<br/>Total Score: 1.0] --> B[URL Length<br/>Weight: 0.57]
    A --> C[HTTPS Presence<br/>Weight: 0.29]
    A --> D[Suspicious Words<br/>Weight: 0.14]
    B --> E[URL1<br/>Score: 0.83]
    B --> F[URL2<br/>Score: 1.00]
    B --> G[URL3<br/>Score: 0.67]
    C --> H[URL1<br/>Score: 1.00]
    C --> I[URL2<br/>Score: 0.00]
    C --> J[URL3<br/>Score: 0.50]
    D --> K[URL1<br/>Score: 1.00]
    D --> L[URL2<br/>Score: 0.50]
    D --> M[URL3<br/>Score: 0.33]
```
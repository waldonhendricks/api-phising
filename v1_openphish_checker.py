import requests
import os

FEED_URL = 'https://openphish.com/feed.txt'
LOCAL_FEED_FILE = 'phishing_feed.txt'

def download_phishing_feed():
    """
    Downloads the latest phishing URLs from OpenPhish feed.
    """
    try:
        response = requests.get(FEED_URL)
        response.raise_for_status()
        with open(LOCAL_FEED_FILE, 'w') as f:
            f.write(response.text)
        print("Feed downloaded successfully.")
    except requests.exceptions.RequestException as e:
        print(f"Error downloading feed: {e}")

def load_phishing_urls():
    """
    Loads phishing URLs from local file into a set for fast checking.
    """
    if not os.path.exists(LOCAL_FEED_FILE):
        download_phishing_feed()
    with open(LOCAL_FEED_FILE, 'r') as f:
        return set(line.strip() for line in f if line.strip())

def check_phishing_url(url_to_check, phishing_urls):
    """
    Checks if a URL is in the phishing database.
    
    Args:
        url_to_check (str): The URL to verify.
        phishing_urls (set): Set of known phishing URLs.
    
    Returns:
        bool: True if phishing, False otherwise.
    """
    return url_to_check in phishing_urls

if __name__ == '__main__':
    # Download/update the feed (run this periodically)
    download_phishing_feed()
    
    # Load URLs into memory
    phishing_urls = load_phishing_urls()
    
    # Test a URL
    test_url = 'http://example-phish-site.com/'  # Replace with real URL
    is_phishing = check_phishing_url(test_url, phishing_urls)
    print(f"{test_url} is {'a phishing site' if is_phishing else 'not in the database'}.")
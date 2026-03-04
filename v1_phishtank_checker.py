import requests

API_ENDPOINT = 'https://checkurl.phishtank.com/checkurl/'
API_KEY = 'your_app_key_here'  # Replace with your actual App Key

def check_phishing_url(url_to_check):
    """
    Checks if a URL is in PhishTank's phishing database.
    
    Args:
        url_to_check (str): The URL to verify.
    
    Returns:
        dict: API response data or error message.
    """
    payload = {
        'url': url_to_check,
        'format': 'json',
        'app_key': API_KEY
    }
    try:
        response = requests.post(API_ENDPOINT, data=payload)
        response.raise_for_status()  # Raise error for bad status codes
        data = response.json()
        return data
    except requests.exceptions.RequestException as e:
        return {'error': str(e)}

if __name__ == '__main__':
    test_url = 'http://example-phish-site.com/'  # Replace with a URL to test
    result = check_phishing_url(test_url)
    print(result)
    if 'results' in result:
        if result['results']['in_database']:
            print(f"Warning: {test_url} is a known phishing site!")
        else:
            print(f"{test_url} is not in the database.")
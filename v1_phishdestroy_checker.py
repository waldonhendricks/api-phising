import requests

API_ENDPOINT = 'https://api.destroy.tools/v1/check'

def check_phishing_url(url_to_check):
    """
    Checks if a URL/domain is associated with phishing threats using PhishDestroy API.
    
    Args:
        url_to_check (str): The URL or domain to verify.
    
    Returns:
        dict: API response data or error message.
    """
    params = {'domain': url_to_check}
    try:
        response = requests.get(API_ENDPOINT, params=params)
        response.raise_for_status()
        data = response.json()
        return data
    except requests.exceptions.RequestException as e:
        return {'error': str(e)}

if __name__ == '__main__':
    test_url = 'example-phish-site.com'  # Replace with a domain/URL to test (e.g., 'phishing-site.com')
    result = check_phishing_url(test_url)
    print(result)
    if 'threat_score' in result:
        if result['threat_score'] > 0:
            print(f"Warning: {test_url} has a threat score of {result['threat_score']}!")
        else:
            print(f"{test_url} appears clean.")
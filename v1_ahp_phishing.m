% AHP for Phishing URL Ranking using OpenPhish Data

% Step 1: Download and Load Phishing URLs
feed_url = 'https://openphish.com/feed.txt';
feed_file = 'phishing_feed.txt';
try
    websave(feed_file, feed_url);
    disp('Feed downloaded.');
catch
    disp('Error downloading feed. Using existing file if available.');
end

% Read URLs
fid = fopen(feed_file, 'r');
urls = textscan(fid, '%s');
fclose(fid);
urls = urls{1};
num_urls = min(length(urls), 10); % Limit for demo (e.g., top 10)
urls = urls(1:num_urls);

% Step 2: Define Criteria and Extract Features
% Criteria: 1. URL Length, 2. HTTPS Presence, 3. Suspicious Words Count
criteria_names = {'URL Length', 'HTTPS Presence', 'Suspicious Words'};
suspicious_words = {'login', 'bank', 'password', 'secure'}; % Example keywords

% Extract features for each URL
features = zeros(num_urls, 3);
for i = 1:num_urls
    url = urls{i};
    features(i, 1) = length(url); % URL length
    features(i, 2) = contains(url, 'https'); % 1 if HTTPS, 0 otherwise
    % Count suspicious words
    word_count = 0;
    for word = suspicious_words
        if contains(lower(url), word{1})
            word_count = word_count + 1;
        end
    end
    features(i, 3) = word_count;
end

% Normalize features to [0,1] scale (higher values = higher risk for all)
features(:,1) = features(:,1) / max(features(:,1)); % Normalize length (shorter better, but invert if needed)
features(:,2) = 1 - features(:,2); % Invert HTTPS (no HTTPS = 1, riskier)
features(:,3) = features(:,3) / max(features(:,3)); % Normalize word count

% Step 3: Pairwise Comparison Matrix for Criteria (Expert Judgment)
% Example: URL Length slightly preferred over HTTPS, HTTPS much preferred over Words
A = [1, 2, 4;   % Length vs others
     0.5, 1, 3; % HTTPS vs others
     0.25, 1/3, 1]; % Words vs others

% Step 4: Calculate Criteria Weights
[n, ~] = size(A);
norm_A = A ./ sum(A, 1); % Normalize columns
weights = mean(norm_A, 2); % Average rows for weights

% Consistency Check
lambda_max = mean(sum(A .* norm_A, 2) ./ weights);
CI = (lambda_max - n) / (n - 1);
RI = 0.58; % Random Index for n=3
CR = CI / RI;
if CR < 0.1
    disp('Criteria matrix is consistent.');
else
    disp('Revise criteria comparisons.');
end

% Step 5: Score Alternatives (URLs)
% features is already the score matrix (rows: URLs, columns: criteria)
final_scores = features * weights;

% Step 6: Rank URLs
[~, rank_idx] = sort(final_scores, 'descend');
disp('Top Phishing URLs by AHP Score:');
for i = 1:num_urls
    fprintf('%d. %s (Score: %.3f)\n', i, urls{rank_idx(i)}, final_scores(rank_idx(i)));
end
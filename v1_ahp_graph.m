% AHP Hierarchy Visualization

% Define nodes: 1=Goal, 2-4=Criteria, 5-7=Alternatives
nodes = {'Evaluate Phishing Risk', 'URL Length', 'HTTPS Presence', 'Suspicious Words', 'URL1', 'URL2', 'URL3'};

% Define parent indices (tree structure)
% Parent of 1 is 0 (root), parents of 2-4 are 1, parents of 5-7 are 2 (under URL Length for demo)
parent = [0, 1, 1, 1, 2, 2, 2];  % Adjust for your hierarchy

% Plot the tree
figure;
treeplot(parent);
title('AHP Hierarchy for Phishing URL Evaluation');

% Label nodes
[x, y] = treelayout(parent);
text(x, y, nodes, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 10);

% Optional: Use graph for directed edges
% G = digraph([1 1 1 2 2 2], [2 3 4 5 6 7]);
% plot(G, 'Layout', 'layered');
% labelnode(G, 1:7, nodes);
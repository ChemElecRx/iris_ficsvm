% Load data
load fisheriris;
inds = ~strcmp(species,'versicolor');
X = meas(inds,1:2);
s = species(inds);

% Fit SVM model
SVMModel = fitcsvm(X,s);

% Get support vectors, beta, and bias
sv = SVMModel.SupportVectors; % Support vectors
beta = SVMModel.Beta; % Linear predictor coefficients
b = SVMModel.Bias; % Bias term

% Plot data points for setosa and virginica
figure;
hold on;
gscatter(X(:,1), X(:,2), s, 'rb', 'xo');
plot(sv(:,1), sv(:,2), 'ko', 'MarkerSize', 10); % Support vectors in black circles

% Plot decision boundary
X1 = linspace(min(X(:,1)),max(X(:,1)),100);
X2 = -(beta(1)/beta(2)*X1)-b/beta(2);
h1 = plot(X1, X2, 'k-', 'LineWidth', 2);

% Calculate and plot margins
m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
X1margin_low = X1 + beta(1) * m;
X2margin_low = X2 + beta(2) * m;
X1margin_high = X1 - beta(1) * m;
X2margin_high = X2 - beta(2) * m;
h2 = plot(X1margin_high, X2margin_high, 'b--', 'LineWidth', 1.5);
h3 = plot(X1margin_low, X2margin_low, 'r--', 'LineWidth', 1.5);

% Plot labels
xlabel('X_1 (Sepal Length in cm)')
ylabel('X_2 (Sepal Width in cm)')
legend({'setosa', 'virginica', 'Support Vector', ...
    'Boundary Line', 'Upper Margin', 'Lower Margin'}, ...
    'Location', 'Best');

% Release hold
hold off;

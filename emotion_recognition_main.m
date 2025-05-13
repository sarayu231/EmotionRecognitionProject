% Load Dataset
data = readtable('emotion_dataset.csv');

% Features and Labels
features = data{:,2:end};
labels = categorical(data{:,1});

% Feature Scaling (important for KNN)
features = normalize(features);

% Train-Test Split
cv = cvpartition(labels, 'HoldOut', 0.3);
trainIdx = training(cv);
testIdx = test(cv);

X_train = features(trainIdx,:);
X_test = features(testIdx,:);
y_train = labels(trainIdx);
y_test = labels(testIdx);

% SVM Classifier
svm = fitcecoc(X_train, y_train);
pred_svm = predict(svm, X_test);
acc_svm = mean(pred_svm == y_test)*100;
figure, confusionchart(y_test, pred_svm);
title(sprintf('SVM Confusion Matrix (Accuracy: %.2f%%)', acc_svm));

% Decision Tree
tree = fitctree(X_train, y_train);
pred_tree = predict(tree, X_test);
acc_tree = mean(pred_tree == y_test)*100;
figure, confusionchart(y_test, pred_tree);
title(sprintf('Decision Tree Confusion Matrix (Accuracy: %.2f%%)', acc_tree));

% KNN Classifier (Improved)
knn = fitcknn(X_train, y_train, 'NumNeighbors', 5, 'Distance', 'euclidean');
pred_knn = predict(knn, X_test);
acc_knn = mean(pred_knn == y_test)*100;
figure, confusionchart(y_test, pred_knn);
title(sprintf('KNN Confusion Matrix (Accuracy: %.2f%%)', acc_knn));

% Ensemble (Bagged Trees)
ens = fitcensemble(X_train, y_train, 'Method', 'Bag');
pred_ens = predict(ens, X_test);
acc_ens = mean(pred_ens == y_test)*100;
figure, confusionchart(y_test, pred_ens);
title(sprintf('Ensemble Confusion Matrix (Accuracy: %.2f%%)', acc_ens));

% PCA for Visualization
[coeff, score] = pca(features);
figure;
gscatter(score(:,1), score(:,2), labels);
title('PCA of Emotion Dataset');
xlabel('Principal Component 1');
ylabel('Principal Component 2');

% Feature Importance (Decision Tree)
figure;
bar(tree.predictorImportance);
xticklabels(data.Properties.VariableNames(2:end));
xtickangle(45);
title('Feature Importance (Decision Tree)');

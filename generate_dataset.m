% Emotion Recognition Dataset Generator (Facial + GSR)
% Author: Sarayu's Project
% Description: Generates 600 synthetic emotion samples and saves as CSV

% Step 1: Define emotions and number of samples per emotion
emotions = {'Happy', 'Sad', 'Angry', 'Fear', 'Surprise', 'Neutral'};
samples_per_emotion = 100;
total_samples = samples_per_emotion * length(emotions);

% Step 2: Preallocate arrays
emotion_label = strings(total_samples,1);
mouth_width = zeros(total_samples,1);
eye_distance = zeros(total_samples,1);
eyebrow_raise = zeros(total_samples,1);
smile_intensity = zeros(total_samples,1);
frown_intensity = zeros(total_samples,1);
mean_GSR = zeros(total_samples,1);
GSR_peaks = zeros(total_samples,1);
GSR_slope = zeros(total_samples,1);

% Step 3: Generate data for each emotion
index = 1;
for e = 1:length(emotions)
    for i = 1:samples_per_emotion
        emotion = emotions{e};
        emotion_label(index) = emotion;

        % Default values (common across all emotions)
        eye_distance(index) = rand()*10 + 40;
        GSR_slope(index) = randn()*0.5;

        switch emotion
            case 'Happy'
                mouth_width(index) = rand()*20 + 30;
                smile_intensity(index) = rand()*0.5 + 0.5;
                frown_intensity(index) = rand()*0.2;
                mean_GSR(index) = rand()*2 + 3;
                GSR_peaks(index) = randi([1,3]);
                eyebrow_raise(index) = rand()*0.3;

            case 'Sad'
                mouth_width(index) = rand()*10 + 20;
                smile_intensity(index) = rand()*0.2;
                frown_intensity(index) = rand()*0.5 + 0.5;
                mean_GSR(index) = rand()*2 + 1;
                GSR_peaks(index) = randi([0,2]);
                eyebrow_raise(index) = rand()*0.1;

            case 'Angry'
                mouth_width(index) = rand()*15 + 25;
                smile_intensity(index) = rand()*0.1;
                frown_intensity(index) = rand()*0.6 + 0.4;
                mean_GSR(index) = rand()*3 + 4;
                GSR_peaks(index) = randi([2,5]);
                eyebrow_raise(index) = rand()*0.4;

            case 'Fear'
                mouth_width(index) = rand()*15 + 25;
                smile_intensity(index) = rand()*0.2;
                frown_intensity(index) = rand()*0.3;
                mean_GSR(index) = rand()*3 + 5;
                GSR_peaks(index) = randi([3,6]);
                eyebrow_raise(index) = rand()*0.6 + 0.3;

            case 'Surprise'
                mouth_width(index) = rand()*15 + 25;
                smile_intensity(index) = rand()*0.3;
                frown_intensity(index) = rand()*0.1;
                mean_GSR(index) = rand()*2 + 4;
                GSR_peaks(index) = randi([2,4]);
                eyebrow_raise(index) = rand()*0.6 + 0.3;

            case 'Neutral'
                mouth_width(index) = rand()*10 + 25;
                smile_intensity(index) = rand()*0.1;
                frown_intensity(index) = rand()*0.1;
                mean_GSR(index) = rand()*1 + 2;
                GSR_peaks(index) = randi([0,1]);
                eyebrow_raise(index) = rand()*0.2;
        end

        index = index + 1;
    end
end

% Step 4: Create dataset table
dataset = table(emotion_label, mouth_width, eye_distance, eyebrow_raise, ...
    smile_intensity, frown_intensity, mean_GSR, GSR_peaks, GSR_slope);

% Step 5: Shuffle dataset randomly
shuffled_indices = randperm(height(dataset));
dataset = dataset(shuffled_indices, :);

% Step 6: Save to CSV
writetable(dataset, 'emotion_dataset.csv');
disp('Dataset saved as emotion_dataset.csv');

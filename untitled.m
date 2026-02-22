clc;
clear;
close all;

%% PARAMETERS
k = 3;
n = 3;
m = 8;
group_size = k - 1;

%% READ COLOR IMAGE
img = imread('peppers.png');   % colorful image
img = uint8(img);

[rows, cols, ch] = size(img);

figure; imshow(img); title('Original Color Image');

%% PROCESS EACH CHANNEL SEPARATELY
share_images = cell(1,n);
for i = 1:n
    share_images{i} = zeros(rows,cols,ch,'uint8');
end

recovered_img = zeros(rows,cols,ch,'uint8');

for channel = 1:3
    
    pixels = double(img(:,:,channel));
    pixels = pixels(:);
    
    if mod(length(pixels), group_size) ~= 0
        pad = group_size - mod(length(pixels), group_size);
        pixels = [pixels; zeros(pad,1)];
    end
    
    num_groups = length(pixels)/group_size;
    
    %% GF Setup
    x_keys = gf(1:group_size, m);
    
    V = [gf(1,m) x_keys(1);
         gf(1,m) x_keys(2)];
    V_inv = inv(V);
    
    x_vals = gf(1:k, m);
    V_rec = [gf(1,m) x_vals(1) x_vals(1)^2;
             gf(1,m) x_vals(2) x_vals(2)^2;
             gf(1,m) x_vals(3) x_vals(3)^2];
    V_rec_inv = inv(V_rec);
    
    share_data = gf(zeros(num_groups,n), m);
    
    %% SHARE GENERATION
    for g = 1:num_groups
        
        idx = (g-1)*group_size + (1:group_size);
        batch = gf(pixels(idx), m);
        batch = batch(:);
        
        g_coeff = V_inv * batch;
        
        % Authentication
        data_str = sprintf('%d,', g_coeff.x);
        data_str(end) = [];
        
        md = java.security.MessageDigest.getInstance('SHA-256');
        md.update(uint8(data_str));
        hash_bytes = typecast(md.digest,'uint8');
        
        a0 = gf(hash_bytes(1), m);
        
        for i = 1:n
            x_val = gf(i,m);
            val = a0 + g_coeff(1)*x_val + g_coeff(2)*x_val^2;
            share_data(g,i) = val;
        end
    end
    
    %% Convert shares to images
    for i = 1:n
        
        temp = uint8(share_data.x(:,i));
        temp = temp(1:rows*cols);
        share_images{i}(:,:,channel) = reshape(temp,rows,cols);
    end
    
    %% RECOVERY
    recovered_pixels = [];
    
    for g = 1:num_groups
        
        y_vals = share_data(g,1:k).';
        f_rec = V_rec_inv * y_vals;
        
        a0_rec = f_rec(1);
        g_rec = f_rec(2:end);
        
        % Authentication
        data_str = sprintf('%d,', g_rec.x);
        data_str(end) = [];
        
        md = java.security.MessageDigest.getInstance('SHA-256');
        md.update(uint8(data_str));
        hash_bytes = typecast(md.digest,'uint8');
        
        a0_check = gf(hash_bytes(1), m);
        
        if a0_check ~= a0_rec
            error('Authentication Failed!');
        end
        
        vals = zeros(group_size,1);
        for i = 1:group_size
            x_val = x_keys(i);
            val = g_rec(1)*x_val + g_rec(2)*x_val^2;
            vals(i) = val.x;
        end
        
        recovered_pixels = [recovered_pixels; vals];
    end
    
    recovered_pixels = recovered_pixels(1:rows*cols);
    recovered_img(:,:,channel) = reshape(uint8(recovered_pixels),rows,cols);
end

%% Display Shares
for i = 1:n
    figure; imshow(share_images{i});
    title(['Share Image ', num2str(i)]);
end

%% Display Recovered
figure; imshow(recovered_img);
title('Recovered Color Image');

disp('Color GF Secret Sharing Successful!');
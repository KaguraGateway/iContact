classdef ScanController
    properties
        EmailPattern = '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';
        CompanyPattern = '(株\s*式\s*会\s*社\s*[^\s]+|[^\s]+\s*株\s*式\s*会\s*社)\n';
    end

    methods
        function card = Ocr(obj, img)
            scanStr = ocr(img, "Model","japanese");

            % 名刺だけを輪郭追跡してマスク
            grayImg = rgb2gray(img);
            bw = imbinarize(grayImg);
            bw_filled = imfill(bw, "holes");
            [B, L] = bwboundaries(bw_filled);
            
            mask = false(size(bw));
            for k = 1:length(B)
                boundary = B{k};
                mask(sub2ind(size(mask), boundary(:, 1), boundary(:, 2))) = true;
            end
            mask = imfill(mask, "holes");
            maskedImg = bsxfun(@times, img, cast(mask, "like", img));

            % メアドを取得
            emails = regexp(scanStr.Text, obj.EmailPattern, "match");
            
            % 会社名を取得
            companyNames = regexp(scanStr.Text, obj.CompanyPattern, "match");

            % 当てずっぽうで名前
            texts = splitlines(scanStr.Text);
            name = texts{7};

            % 当てずっぽうで役職
            role = texts{3};

            fileName = name + ".png";
            imwrite(maskedImg, fileName);

            card = BussinessCard(name, emails{1}, companyNames{1}, role, scanStr.Text, fileName);
        end
    end
end

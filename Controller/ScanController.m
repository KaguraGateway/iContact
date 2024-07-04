classdef ScanController
    methods
        function scanStr = Ocr(~, img)
            scanStr = ocr(img, "Model","japanese");
        end
    end
end

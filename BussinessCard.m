classdef BussinessCard
    properties
        Name
        Email
        CompanyName
        Role
        Other
        ImgName
    end

    methods
        function obj = BussinessCard(name, email, companyName, role, other, imgName)
            obj.Name = name;
            obj.Email = email;
            obj.CompanyName = companyName;
            obj.Role = role;
            obj.Other = other;
            obj.ImgName = imgName;
        end
    end
end

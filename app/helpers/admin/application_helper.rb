module Admin::ApplicationHelper
    def roles
        hash = {}
        %w(manager editor viewer).each do |role|
        hash[role.titleize] = role
        end
        hash
    end
end

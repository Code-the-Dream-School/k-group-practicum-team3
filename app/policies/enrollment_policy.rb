class EnrollmentPolicy < ApplicationPolicy
    def new?
        if user && !owns_record?
            !enrolled? && not_past?
        else
            false
        end
    end

    def create?
        if user && !owns_record?
            !enrolled? && not_past?
        else
            false
        end
    end

    def destroy?
        if user
            enrolled? && not_past?
        else
            false
        end
    end

    private

    def organizer?
        user.present? && user.has_role?(:organizer)
    end

    def participant?
        user.present? && user.has_role(:participant)
    end

    def not_past?
        !record.event.past?
    end

    def enrolled?
        record.user_id == user.id
    end

    def owns_record?
        record.user_id == user.id
    end
end

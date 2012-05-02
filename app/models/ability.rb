class Ability
  include CanCan::Ability

  def initialize(user)

       user ||= User.new # guest user (not logged in)
       if user.admin?
         can :manage, :all
         can :edit, :all
         can :export, :all
         can :sign_out
         can :search, :all
         can :searchform, :all
         can :export_csv, :all
       elsif not user.id.nil?
         can :read, :all
         can :create, :all
         can :sign_out
         can :search, :all
         can :searchform, :all
         can :export_csv, :all
         can [:update, :edit, :destroy], Lexeme.all.find_all{|item| item.user == user}
         can [:update, :edit, :destroy], Syntagm.all.find_all{|item| item.user == user}
	     can [:update, :edit, :destroy], Comment.all.find_all{|item| item.user == user}
       else #not logged in
         can :read, :all
         can :sign_in, :sign_up
         can :search, :all
         can :searchform, :all
         can :export_csv, :all
       end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

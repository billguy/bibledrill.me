class Ability
  include CanCan::Ability

  def initialize(user)
    if (user)
      can [:new, :create], Study
      can [:edit, :update, :destroy], Study, id: user.study_ids
    end
  end
end

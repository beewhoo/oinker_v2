class UserMailer < ApplicationMailer
  default from: 'notifications@oinker.com'

  def saved_plan_email
    @date_plans = @date_plan = DatePlan.find(params[:id])
    mail(to: @date_plan.user_id.email, 'Here are your Oinker plan details!')
  end
end

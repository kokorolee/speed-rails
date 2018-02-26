require 'json'

class PartnerAPI < FoxyCrmAPI


  resource :partners do

    desc 'Sign in'
    params do
      requires :email, type: String
      requires :password, type: String
    end

    post 'signin' do
      partner = Partner.find_by(:email => params[:email].downcase)
      error!({ error: "Wrong email or password" }, 422) unless partner and partner.valid_password?(params[:password])
      present partner, with: Entities::PartnerLogin
    end

    desc 'Sign up'
    params do
      requires :email, type: String
      optional :password, type: String

    end

    post 'signup' do

    end

    desc 'Sign out'
    post 'signout' do
      authenticate!

      @current_partner.access_token = nil
      @current_partner.save
      if @current_partner.errors.present?
        status 422
        {error: @current_partner.errors.full_messages[0]}
      else
        status 201
      end
    end


    desc 'Retrieve partner'
    get 'me' do
      authenticate!
      present @current_partner, with: Entities::Partner
    end

    desc 'Update member'
    params do

    end
    put 'me' do

    end

    desc 'Reset password'
    params do
      requires :email, type: String
    end
    post 'forgotpassword' do
      member = Partner.find_by(:email => params[:email].downcase)
      if member.present?
        status 204
        member.send_reset_password_instructions
      else
        error!({ error: "There's no such email address." }, 422)
      end
    end

    desc 'Partner Create Customer'
    params do
      requires :email, type: String
      requires :phone, type: String
      requires :fullname, type: String
      requires :code, type: String
    end

    post 'customers' do
      authenticate!
      customer = Customer.create({
        fullname: params[:fullname],
        code: params[:code],
        phone_number: params[:phone],
        email: params[:email],
        partner_ids: [@current_partner.id]
      });

      status 200
    end

    desc 'Get All Customer of Partner'
    params do
      optional :page, type: Integer
      optional :per_page, type: Integer
    end

    get 'customers' do
      authenticate!
      per_page = params[:per_page].blank? ? 20 : params[:per_page].to_i
      page = params[:page].blank? ? 1 : params[:page].to_i
      customers = @current_partner.customers
      total = customers.count
      customers = customers.page(page).per(per_page)

      data = {
        id: @current_partner.id,
        total: total,
        customer: customers.pluck(:code, :fullname)
      }

      present data
    end

  end
end

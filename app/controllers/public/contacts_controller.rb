class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      pp "ENV内容-------------------#{ENV['SEND_MAIL_PASSWORD']}"
      ContactMailer.contact_mail(@contact).deliver
      flash[:notice] = "お問い合わせ内容を送信しました。"
      redirect_to post_items_path
    else
      flash[:alert] = "送信できませんでした。名前とお問い合わせ内容が入力されているか確認してください。"
      redirect_to new_contact_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :content, :email)
  end

end

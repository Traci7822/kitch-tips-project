class TipsController < ApplicationController

  include Validify::InstanceMethods

   get '/:id/edit' do
     if logged_in?(session)
       @tip = Tip.find_by(id: params[:id])
        erb :"/tip/edit"
      else
        flash[:message] = "You must be logged in to edit a tip, please login and try again"
        redirect "/login"
      end
   end

   patch '/tip/:id' do
     if logged_in?(session)
       if !params_blank?(params)
         tip = Tip.find_by(id: params[:id])
         tip.update(name: params[:name], main_ingredient: params[:main_ingredient], tip: params[:tip])
         redirect "/user"
       end
     else
       redirect "/login"
     end
   end

   delete '/tip/:id/delete' do
     if logged_in?(session)
       tip = Tip.find_by(id: params[:id])
       tip.delete
       redirect "/user"
     else
       redirect "/login"
     end
   end

   get '/a_z_index' do
     @tips = Tip.all
     @letter_tips = []
     def letter_list(letter)
       @tips.each do |tip|
         if tip.main_ingredient.downcase.split("").first == letter.downcase
           @letter_tips << tip
         end
       end
       @letter_tips.sort_by! {|x| x.main_ingredient.downcase}
     end
     erb :a_z_index
   end

   get '/:id/show' do
     @tip = Tip.find_by(id: params[:id])
     erb :"/tip/show"
   end
 end

class BlogController < ApplicationController

def index
	@fotos = Foto.all
end

def foto_nueva
	@foto = Foto.new
end

def guardar_foto
	@foto =  Foto.new(params[:foto])
	if @foto.save
		flash[:mensaje] = "Foto guardada con exito"
		redirect_to :action => 'index'
	else
		#aki si no cumplio la validacion
		flash[:mensaje] = "El campo del titulo e imagen son obligatorios"
		render :action => 'foto_nueva'	
	end
end

end

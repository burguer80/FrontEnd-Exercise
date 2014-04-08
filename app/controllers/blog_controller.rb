class BlogController < ApplicationController
 #http_basic_authenticate_with :name => "sergio", 
 #							  :password => "secreto"
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

def registro 
	@usuario = Usuario.new
end

def crear_usuario
	@usuario = Usuario.new(params[:usuario])
	#<----atributo virtual------------->
	@usuario.password = params[:usuario][:password_digest] 
if @usuario.save
  	flash[:notice] = "Bienvenido: #{@usuario.nombre}"
 	redirect_to :action => 'foto_nueva'
else
  @usuario.password_digest = ''
  flash[:notice] = "Los campos son obligatorios; Correo ya existe"
  render :action => 'registro'
end
end

end

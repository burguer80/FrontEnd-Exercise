class BlogController < ApplicationController
  #<--valida excepto el login------------------->
  before_filter :valida_autentificacion, :except => [:login, :index, :registro, :crear_usuario]
  #<--protege los metodos criticos------------------->
  skip_before_filter :valida_autentificacion!, :except => [:foto_nueva, :guardar_foto]



 def valida_autentificacion
 	unless session[:usuario]
    	redirect_to :action => "login"
    end
end

def logout
       session[:usuario] = nil
       redirect_to :action => 'login'
end

def login
    if request.post?
  		  @usuario = Usuario.find_by_email(params[:usuario][:email])
  			if @usuario && @usuario.authenticate(params[:usuario][:password])
 			   session[:usuario] = @usuario.id
 			   redirect_to :action => 'foto_nueva'
  			 else
  			   flash[:mensaje] = "Email o contrasena invalida"
   			   render :action => 'login'
   			end
 else
   @usuario = Usuario.new
 end
end


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

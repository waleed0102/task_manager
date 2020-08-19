class ServersController < ApplicationController

  def index
    @servers = Server.active
    @tasks = Task.all
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      redirect_to servers_path
    else
      redirect_to servers_path
    end
  end

  def destroy
    @server = Server.find(params[:id])
    if Server.active.count == 1
      return redirect_to servers_path
    elsif @server.deletable
      @server.destroy
    else
      @server.update(deletable: true)
    end
    redirect_to servers_path
  end

  private

  def server_params
    params.require(:server).permit(:name)
  end
end

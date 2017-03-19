class Web::Admin::ProtocolsController < Web::Admin::ApplicationController
  before_filter :choose_teams, only: [ :new, :edit ]

  def index
    if params[:search]
      protocols = Protocol.active.search_everywhere params[:search]
    else
      protocols = Protocol.send params[:scope]
    end
    @protocols = protocols.page(params[:page]).decorate
  end

  def new
    @protocol_form = ProtocolForm.new_with_model
  end

  def edit
    @protocol_form = ProtocolForm.find_with_model params[:id]
  end

  def create
    #FIXME try to add to form
    params[:protocol][:document_id] = Document.create!(file: params[:protocol][:document], title: params[:protocol][:title]).id
    @protocol_form = ProtocolForm.new_with_model
    if @protocol_form.submit params[:protocol]
      redirect_to admin_protocols_path
    else
      choose_teams
      render action: :new
    end
  end

  def update
    @protocol_form = ProtocolForm.find_with_model params[:id]
    @protocol_form.submit(params[:protocol])
    if @protocol_form.save
      redirect_to admin_protocols_path
    else
      choose_teams
      render action: :edit
    end
  end

  def destroy
    @protocol = Protocol.find params[:id]
    @protocol.remove
    redirect_to admin_protocols_path
  end
end
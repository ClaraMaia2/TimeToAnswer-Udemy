class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all.order(:description).page(params[:page])
  end

  def edit
  end

  def update
    if @subject.update(params_subject)
      redirect_to admins_backoffice_subjects_path, notice: "Subject successfully updated!"
    else
      render :edit
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params_subject)

    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Subject successfully created!"
    else
      render :new
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Subject successfully deleted!"
    else
      render :index
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def params_subject
    params.require(:subject).permit(:description)
  end
end

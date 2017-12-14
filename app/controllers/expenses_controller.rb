class ExpensesController < ApplicationController
  before_action :set_expense, only: [:edit, :update, :destroy]

  def index
    options = params
    @expenses = Fetchers::FetchExpensesService.decorated(options)
  end

  def cancelled
    options = params
    @expenses = Fetchers::FetchExpensesService.decorated(options)
  end

  def new
    @expense = Expense.new
  end

  def create
    store_id = expense_params[:store_id].present? ? expense_params[:store_id] : current_user.store_id
    expense = Expense.create(user: current_user, store_id: store_id, name: expense_params[:name], price: expense_params[:price])
    flash[:success] = 'Egreso creado exitosamente.'
    redirect_to expenses_url
  end

  def edit
    case params[:origin]
    when "CANCELLED"
      @expense.cancel ? flash[:success] = 'Egreso anulado exitosamente.' : flash[:danger] = "Imposible anular egreso. Egreso #{ExpenseDecorator.decorate(@expense).status_name}."
      redirect_to expenses_url
    end
  end

  def update
    @expense.update(expense_params)
    flash[:success] = 'Egreso actualizado exitosamente.'
    redirect_to expenses_url
  end

  def destroy
    @expense.destroy
    redirect_to expenses_url, notice: 'Egreso eliminado exitosamente.'
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :price, :store_id)
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end
end

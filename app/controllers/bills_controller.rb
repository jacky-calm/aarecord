class BillsController < ApplicationController
  # GET /bills
  # GET /bills.json
  def index
    @bills_int = Bill.where(:type=>Bill::TYPE_INT).or({:debtor=>current_user}, {:debtee=>current_user})
    @bills_gap_debt = Bill.where(:type=>Bill::TYPE_GAP, :debtor=>current_user, :fee.gt=>0, :status=>Bill::STATUS_NEW).desc(:id)
    @bills_gap_debt_hash = {}
    @bills_gap_debt.each do |b|
      (@bills_gap_debt_hash[b.debtee] ||= []) << b
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
    @bill = Bill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(params[:bill])

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render json: @bill, status: :created, location: @bill }
      else
        format.html { render action: "new" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.json
  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST
  # /bills/1/pay
  def pay
    @bill = Bill.find(params[:id])
    respond_to do |format|
      if @bill.pay
        if @bill.account.clear?
          format.js{render :json => {:result => "clear", :bill_id=>@bill.id.to_s, :account_id=>@bill.account.id.to_s}, :layout => false}
        else
          format.js{render :json => {:result => "paid", :bill_id=>@bill.id.to_s, :account_id=>@bill.account.id.to_s}, :layout => false}
        end
      else
        format.js{render :json => {:result => "fail"}, :layout => false }
      end
    end

  end

  def clear
    debtee = User.find(params[:debtee_id])
    bills = Bill.where(:debtor=>current_user, :debtee=>debtee, :status=>Bill::STATUS_NEW)
    bills.each {|b| b.update_attributes :status=>Bill::STATUS_PAID }
    respond_to do |format|
      format.html { redirect_to bills_path, notice: 'Debt was successfully cleared.' }
      format.js{render :json => {:result => "success", :debtee_id=>debtee.id.to_s}, :layout => false}
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url }
      format.json { head :no_content }
    end
  end
end

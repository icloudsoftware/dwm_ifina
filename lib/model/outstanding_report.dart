class OutstandingReportModel {
  String? loanno;
  String? name;
  String? pno;
  String? loantype;
  String? status;
  String? principal;
  String? interest;
  String? dueBalance;
  String? totalPendingBalance;

  OutstandingReportModel(
      {this.loanno,
      this.name,
      this.pno,
      this.loantype,
      this.status,
      this.principal,
      this.interest,
      this.dueBalance,
      this.totalPendingBalance});

  OutstandingReportModel.fromJson(Map<String, dynamic> json) {
    loanno = json['loanno'];
    name = json['name'];
    pno = json['pno'];
    loantype = json['loantype'];
    status = json['status'];
    principal = json['principal'];
    interest = json['interest'];
    dueBalance = json['due_balance'];
    totalPendingBalance = json['total_pending_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanno'] = this.loanno;
    data['name'] = this.name;
    data['pno'] = this.pno;
    data['loantype'] = this.loantype;
    data['status'] = this.status;
    data['principal'] = this.principal;
    data['interest'] = this.interest;
    data['due_balance'] = this.dueBalance;
    data['total_pending_balance'] = this.totalPendingBalance;
    return data;
  }
}

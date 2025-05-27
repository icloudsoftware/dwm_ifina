class Loans {
    String? dailyLoans;
    String? dailyClosedLoans;
    String? dailyLoansAmount;
    String? dailyTotalLoansAmount;
    String? weeklyLoans;
    String? weeklyClosedLoans;
    String? weeklyLoansAmount;
    String? weeklyTotalLoansAmount;
    String? monthlyLoans;
    String? monthlyClosedLoans;
    String? monthlyLoansAmount;
    String? monthlyTotalLoansAmount;
    int? totalHpAmount;
    int? totalPassAmount;
    int? totalHpamountAmount;
    int? totalDueamtAmount;
    int? principalBalance;
    String? dailyPromiseCustomer;
    String? weeklyPromiseCustomer;
    String? monthlyPromiseCustomer;

    Loans({
        this.dailyLoans,
        this.dailyClosedLoans,
        this.dailyLoansAmount,
        this.dailyTotalLoansAmount,
        this.weeklyLoans,
        this.weeklyClosedLoans,
        this.weeklyLoansAmount,
        this.weeklyTotalLoansAmount,
        this.monthlyLoans,
        this.monthlyClosedLoans,
        this.monthlyLoansAmount,
        this.monthlyTotalLoansAmount,
        this.totalHpAmount,
        this.totalPassAmount,
        this.totalHpamountAmount,
        this.totalDueamtAmount,
        this.principalBalance,
        this.dailyPromiseCustomer,
        this.weeklyPromiseCustomer,
        this.monthlyPromiseCustomer,
    });

    factory Loans.fromJson(Map<String, dynamic> json) => Loans(
        dailyLoans: json["daily loans"],
        dailyClosedLoans: json["daily closed loans"],
        dailyLoansAmount: json["daily loans amount"],
        dailyTotalLoansAmount: json["daily total loans amount"],
        weeklyLoans: json["Weekly loans"],
        weeklyClosedLoans: json["Weekly closed loans"],
        weeklyLoansAmount: json["Weekly loans amount"],
        weeklyTotalLoansAmount: json["Weekly total loans amount"],
        monthlyLoans: json["Monthly loans"],
        monthlyClosedLoans: json["Monthly closed loans"],
        monthlyLoansAmount: json["Monthly loans amount"],
        monthlyTotalLoansAmount: json["Monthly total loans amount"],
        totalHpAmount: json["Total HP Amount"],
        totalPassAmount: json["total pass amount"],
        totalHpamountAmount: json["total hpamount amount"],
        totalDueamtAmount: json["total dueamt amount"],
        principalBalance: json["Principal Balance"],
        dailyPromiseCustomer: json["daily promise customer"],
        weeklyPromiseCustomer: json["Weekly promise customer"],
        monthlyPromiseCustomer: json["Monthly promise customer"],
    );

    Map<String, dynamic> toJson() => {
        "daily loans": dailyLoans,
        "daily closed loans": dailyClosedLoans,
        "daily loans amount": dailyLoansAmount,
        "daily total loans amount": dailyTotalLoansAmount,
        "Weekly loans": weeklyLoans,
        "Weekly closed loans": weeklyClosedLoans,
        "Weekly loans amount": weeklyLoansAmount,
        "Weekly total loans amount": weeklyTotalLoansAmount,
        "Monthly loans": monthlyLoans,
        "Monthly closed loans": monthlyClosedLoans,
        "Monthly loans amount": monthlyLoansAmount,
        "Monthly total loans amount": monthlyTotalLoansAmount,
        "Total HP Amount": totalHpAmount,
        "total pass amount": totalPassAmount,
        "total hpamount amount": totalHpamountAmount,
        "total dueamt amount": totalDueamtAmount,
        "Principal Balance": principalBalance,
        "daily promise customer": dailyPromiseCustomer,
        "Weekly promise customer": weeklyPromiseCustomer,
        "Monthly promise customer": monthlyPromiseCustomer,
    };
}

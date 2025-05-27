import 'dart:convert';

FullViewModel fullViewModelFromJson(String str) =>
    FullViewModel.fromJson(json.decode(str));

String fullViewModelToJson(FullViewModel data) => json.encode(data.toJson());

class FullViewModel {
  String? fid;
  String? hpl;
  String? uid;
  String? vno;
  String? name;
  String? no;
  String? duedate;
  String? dueamount;
  String? rno;
  String? paydate;
  String? paymnt;
  String? payyr;
  String? dfaultdate;
  String? fine;
  String? amt;
  String? bal;
  String? urname;
  String? pass;
  String? bil;
  String? prno;
  String? paybefore;
  String? roll;
  String? pri;
  String? duedate1;
  String? nname;
  String? area;
  String? status;
  String? hloan;
  String? hloanrmk;
  String? remarks;
  String? mfin;
  String? scode;
  String? createdate;
  String? altby;
  String? altdate;
  String? mode;
  String? hlbal;
  String? addless;
  String? rloan;
  String? hlrmk;
  String? nddate;
  DateTime? paydate2;
  String? lddate;
  String? loantype;

  FullViewModel({
    this.fid,
    this.hpl,
    this.uid,
    this.vno,
    this.name,
    this.no,
    this.duedate,
    this.loantype,
    this.dueamount,
    this.rno,
    this.paydate,
    this.paymnt,
    this.payyr,
    this.dfaultdate,
    this.fine,
    this.amt,
    this.bal,
    this.urname,
    this.pass,
    this.bil,
    this.prno,
    this.paybefore,
    this.roll,
    this.pri,
    this.duedate1,
    this.nname,
    this.area,
    this.status,
    this.hloan,
    this.hloanrmk,
    this.remarks,
    this.mfin,
    this.scode,
    this.createdate,
    this.altby,
    this.altdate,
    this.mode,
    this.hlbal,
    this.addless,
    this.rloan,
    this.hlrmk,
    this.nddate,
    this.paydate2,
    this.lddate,
  });

  factory FullViewModel.fromJson(Map<String, dynamic> json) => FullViewModel(
        fid: json["fid"],
        hpl: json["hpl"],
        uid: json["uid"],
        vno: json["vno"],
        name: json["name"],
        no: json["no"],
        duedate: json["duedate"],
        dueamount: json["dueamount"],
        rno: json["rno"],
        paydate: json["paydate"],
        loantype: json['loantype'],
        paymnt: json["paymnt"],
        payyr: json["payyr"],
        dfaultdate: json["dfaultdate"],
        fine: json["fine"],
        amt: json["amt"],
        bal: json["bal"],
        urname: json["urname"],
        pass: json["pass"],
        bil: json["bil"],
        prno: json["prno"],
        paybefore: json["paybefore"],
        roll: json["roll"],
        pri: json["pri"],
        duedate1: json["duedate1"],
        nname: json["nname"],
        area: json["area"],
        status: json["status"],
        hloan: json["hloan"],
        hloanrmk: json["hloanrmk"],
        remarks: json["remarks"],
        mfin: json["mfin"],
        scode: json["scode"],
        createdate: json["createdate"],
        altby: json["altby"],
        altdate: json["altdate"],
        mode: json["mode"],
        hlbal: json["hlbal"],
        addless: json["addless"],
        rloan: json["rloan"],
        hlrmk: json["hlrmk"],
        nddate: json["nddate"],
        paydate2:
            json["paydate2"] == null ? null : DateTime.parse(json["paydate2"]),
        lddate: json["lddate"],
      );

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "hpl": hpl,
        "uid": uid,
        "vno": vno,
        "name": name,
        "no": no,
        'loantype': loantype,
        "duedate": duedate,
        "dueamount": dueamount,
        "rno": rno,
        "paydate": paydate,
        "paymnt": paymnt,
        "payyr": payyr,
        "dfaultdate": dfaultdate,
        "fine": fine,
        "amt": amt,
        "bal": bal,
        "urname": urname,
        "pass": pass,
        "bil": bil,
        "prno": prno,
        "paybefore": paybefore,
        "roll": roll,
        "pri": pri,
        "duedate1": duedate1,
        "nname": nname,
        "area": area,
        "status": status,
        "hloan": hloan,
        "hloanrmk": hloanrmk,
        "remarks": remarks,
        "mfin": mfin,
        "scode": scode,
        "createdate": createdate,
        "altby": altby,
        "altdate": altdate,
        "mode": mode,
        "hlbal": hlbal,
        "addless": addless,
        "rloan": rloan,
        "hlrmk": hlrmk,
        "nddate": nddate,
        "paydate2":
            "${paydate2!.year.toString().padLeft(4, '0')}-${paydate2!.month.toString().padLeft(2, '0')}-${paydate2!.day.toString().padLeft(2, '0')}",
        "lddate": lddate,
      };
}

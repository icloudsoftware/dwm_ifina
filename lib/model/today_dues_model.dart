class TodayDuesModel {
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
  String? paydate2;
  String? lddate;
  String? line;
  String? id;
  String? cid;
  String? cidl;
  String? pno;
  String? address;
  String? address1;
  String? address2;
  String? npno;
  String? ada;
  String? nada;
  String? mgroup;
  String? bank;
  String? samt;
  String? uimg;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? lat;
  String? lang;
  String? acc;
  String? minc;
  String? job;
  String? efee;
  String? edate;
  String? lname;
  String? fname;
  String? mname;
  String? hname;
  String? kaddress;
  String? kaddress1;
  String? kaddress2;
  String? marit;
  String? lyear;
  String? educ;
  String? relig;
  String? catbc;
  String? caste;
  String? subcaste;
  String? nrep;
  String? nlname;
  String? nfname;
  String? nmname;
  String? nhname;
  String? nmarit;
  String? ndob;
  String? ngender;
  String? njob;
  String? neduc;
  String? htype;
  String? naddress;
  String? naddress1;
  String? naddress2;
  String? gcode;
  String? loantype;
  int? pendingamount;
  String? msg;

  TodayDuesModel(
      {this.fid,
      this.hpl,
      this.uid,
      this.vno,
      this.name,
      this.no,
      this.duedate,
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
      this.line,
      this.id,
      this.cid,
      this.cidl,
      this.pno,
      this.address,
      this.address1,
      this.address2,
      this.npno,
      this.ada,
      this.nada,
      this.mgroup,
      this.bank,
      this.samt,
      this.uimg,
      this.img1,
      this.img2,
      this.img3,
      this.img4,
      this.lat,
      this.lang,
      this.acc,
      this.minc,
      this.job,
      this.efee,
      this.edate,
      this.lname,
      this.fname,
      this.mname,
      this.hname,
      this.kaddress,
      this.kaddress1,
      this.kaddress2,
      this.marit,
      this.lyear,
      this.educ,
      this.relig,
      this.catbc,
      this.caste,
      this.subcaste,
      this.nrep,
      this.nlname,
      this.nfname,
      this.nmname,
      this.nhname,
      this.nmarit,
      this.ndob,
      this.ngender,
      this.njob,
      this.neduc,
      this.htype,
      this.naddress,
      this.naddress1,
      this.naddress2,
      this.gcode,
      this.loantype,
      this.pendingamount,
      this.msg});

  TodayDuesModel.fromJson(Map<String, dynamic> json) {
    fid = json['fid'];
    hpl = json['hpl'];
    uid = json['uid'];
    vno = json['vno'];
    name = json['name'];
    no = json['no'];
    duedate = json['duedate'];
    dueamount = json['dueamount'];
    rno = json['rno'];
    paydate = json['paydate'];
    paymnt = json['paymnt'];
    payyr = json['payyr'];
    dfaultdate = json['dfaultdate'];
    fine = json['fine'];
    amt = json['amt'];
    bal = json['bal'];
    urname = json['urname'];
    pass = json['pass'];
    bil = json['bil'];
    prno = json['prno'];
    paybefore = json['paybefore'];
    roll = json['roll'];
    pri = json['pri'];
    duedate1 = json['duedate1'];
    nname = json['nname'];
    area = json['area'];
    status = json['status'];
    hloan = json['hloan'];
    hloanrmk = json['hloanrmk'];
    remarks = json['remarks'];
    mfin = json['mfin'];
    scode = json['scode'];
    createdate = json['createdate'];
    altby = json['altby'];
    altdate = json['altdate'];
    mode = json['mode'];
    hlbal = json['hlbal'];
    addless = json['addless'];
    rloan = json['rloan'];
    hlrmk = json['hlrmk'];
    nddate = json['nddate'];
    paydate2 = json['paydate2'];
    lddate = json['lddate'];
    line = json['line'];
    id = json['id'];
    cid = json['cid'];
    cidl = json['cidl'];
    pno = json['pno'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    npno = json['npno'];
    ada = json['ada'];
    nada = json['nada'];
    mgroup = json['mgroup'];
    bank = json['bank'];
    samt = json['samt'];
    uimg = json['uimg'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    lat = json['lat'];
    lang = json['lang'];
    acc = json['acc'];
    minc = json['minc'];
    job = json['job'];
    efee = json['efee'];
    edate = json['edate'];
    lname = json['lname'];
    fname = json['fname'];
    mname = json['mname'];
    hname = json['hname'];
    kaddress = json['kaddress'];
    kaddress1 = json['kaddress1'];
    kaddress2 = json['kaddress2'];
    marit = json['marit'];
    lyear = json['lyear'];
    educ = json['educ'];
    relig = json['relig'];
    catbc = json['catbc'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    nrep = json['nrep'];
    nlname = json['nlname'];
    nfname = json['nfname'];
    nmname = json['nmname'];
    nhname = json['nhname'];
    nmarit = json['nmarit'];
    ndob = json['ndob'];
    ngender = json['ngender'];
    njob = json['njob'];
    neduc = json['neduc'];
    htype = json['htype'];
    naddress = json['naddress'];
    naddress1 = json['naddress1'];
    naddress2 = json['naddress2'];
    gcode = json['gcode'];
    loantype = json['loantype'];
    pendingamount = json['pendingamount'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fid'] = this.fid;
    data['hpl'] = this.hpl;
    data['uid'] = this.uid;
    data['vno'] = this.vno;
    data['name'] = this.name;
    data['no'] = this.no;
    data['duedate'] = this.duedate;
    data['dueamount'] = this.dueamount;
    data['rno'] = this.rno;
    data['paydate'] = this.paydate;
    data['paymnt'] = this.paymnt;
    data['payyr'] = this.payyr;
    data['dfaultdate'] = this.dfaultdate;
    data['fine'] = this.fine;
    data['amt'] = this.amt;
    data['bal'] = this.bal;
    data['urname'] = this.urname;
    data['pass'] = this.pass;
    data['bil'] = this.bil;
    data['prno'] = this.prno;
    data['paybefore'] = this.paybefore;
    data['roll'] = this.roll;
    data['pri'] = this.pri;
    data['duedate1'] = this.duedate1;
    data['nname'] = this.nname;
    data['area'] = this.area;
    data['status'] = this.status;
    data['hloan'] = this.hloan;
    data['hloanrmk'] = this.hloanrmk;
    data['remarks'] = this.remarks;
    data['mfin'] = this.mfin;
    data['scode'] = this.scode;
    data['createdate'] = this.createdate;
    data['altby'] = this.altby;
    data['altdate'] = this.altdate;
    data['mode'] = this.mode;
    data['hlbal'] = this.hlbal;
    data['addless'] = this.addless;
    data['rloan'] = this.rloan;
    data['hlrmk'] = this.hlrmk;
    data['nddate'] = this.nddate;
    data['paydate2'] = this.paydate2;
    data['lddate'] = this.lddate;
    data['line'] = this.line;
    data['id'] = this.id;
    data['cid'] = this.cid;
    data['cidl'] = this.cidl;
    data['pno'] = this.pno;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['npno'] = this.npno;
    data['ada'] = this.ada;
    data['nada'] = this.nada;
    data['mgroup'] = this.mgroup;
    data['bank'] = this.bank;
    data['samt'] = this.samt;
    data['uimg'] = this.uimg;
    data['img1'] = this.img1;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['img4'] = this.img4;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['acc'] = this.acc;
    data['minc'] = this.minc;
    data['job'] = this.job;
    data['efee'] = this.efee;
    data['edate'] = this.edate;
    data['lname'] = this.lname;
    data['fname'] = this.fname;
    data['mname'] = this.mname;
    data['hname'] = this.hname;
    data['kaddress'] = this.kaddress;
    data['kaddress1'] = this.kaddress1;
    data['kaddress2'] = this.kaddress2;
    data['marit'] = this.marit;
    data['lyear'] = this.lyear;
    data['educ'] = this.educ;
    data['relig'] = this.relig;
    data['catbc'] = this.catbc;
    data['caste'] = this.caste;
    data['subcaste'] = this.subcaste;
    data['nrep'] = this.nrep;
    data['nlname'] = this.nlname;
    data['nfname'] = this.nfname;
    data['nmname'] = this.nmname;
    data['nhname'] = this.nhname;
    data['nmarit'] = this.nmarit;
    data['ndob'] = this.ndob;
    data['ngender'] = this.ngender;
    data['njob'] = this.njob;
    data['neduc'] = this.neduc;
    data['htype'] = this.htype;
    data['naddress'] = this.naddress;
    data['naddress1'] = this.naddress1;
    data['naddress2'] = this.naddress2;
    data['gcode'] = this.gcode;
    data['loantype'] = this.loantype;
    data['pendingamount'] = this.pendingamount;
    data['msg'] = this.msg;
    return data;
  }
}
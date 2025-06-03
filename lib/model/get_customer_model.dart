class getcus {
  String? id;
  String? cid;
  String? cidl;
  String? name;
  String? pno;
  String? address;
  String? address1;
  String? address2;
  String? nname;
  String? scode;
  String? mfin;
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
  String? area;
  String? line;

  getcus(
      {this.id,
      this.cid,
      this.cidl,
      this.name,
      this.pno,
      this.address,
      this.address1,
      this.address2,
      this.nname,
      this.scode,
      this.mfin,
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
      this.area,
      this.line});

  getcus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cid = json['cid'];
    cidl = json['cidl'];
    name = json['name'];
    pno = json['pno'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    nname = json['nname'];
    scode = json['scode'];
    mfin = json['mfin'];
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
    area = json['area'];
    line = json['line'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cid'] = this.cid;
    data['cidl'] = this.cidl;
    data['name'] = this.name;
    data['pno'] = this.pno;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['nname'] = this.nname;
    data['scode'] = this.scode;
    data['mfin'] = this.mfin;
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
    data['area'] = this.area;
    data['line'] = this.line;
    return data;
  }
}
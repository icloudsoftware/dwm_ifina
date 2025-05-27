class getcus {
  String? id;
  String? hpl;
  String? hplt;
  String? name;
  String? pno;
  String? spname;
  String? pnoresi;
  String? fname;
  String? pnoresi1;
  String? mname;
  String? pnoresi2;
  String? address;
  String? address1;
  String? address2;
  String? houserent;
  String? geo;
  String? ogeo;
  String? bba;
  String? pgramo;
  String? intert;
  String? rname;
  String? upp4;
  String? oaddress;
  String? oaddress1;
  String? oaddress2;
  String? refpno;
  String? rdate;
  String? area;
  String? dob;
  String? gi1;
  String? gg1;
  String? gi2;
  String? g2;
  String? upp1;
  String? upp2;
  String? upp3;
  String? lmark;
  String? rrname;
  String? mfin;
  String? nname;
  String? npno;
  String? nspname;
  String? npnoresi;
  String? nfname;
  String? npnoresi1;
  String? nmname;
  String? npnoresi2;
  String? naddress;
  String? naddress1;
  String? naddress2;
  String? nhouserent;
  String? ngeo;
  String? nbba;
  String? npgramo;
  String? nintert;
  String? nrname;
  String? nupp4;
  String? noaddress;
  String? noaddress1;
  String? noaddress2;
  String? nrefpno;
  String? narea;
  String? ndob;
  String? ngi1;
  String? ngg1;
  String? ngi2;
  String? ng2;
  String? nupp1;
  String? nupp2;
  String? nupp3;
  String? nlmark;
  String? nrrname;
  String? geooff;
  String? sname;
  String? spnoresi2;
  String? dname;
  String? dpnoresi2;
  String? cage;
  String? gage;
  String? designation;

  getcus(
      {this.id,
      this.hpl,
      this.hplt,
      this.name,
      this.pno,
      this.spname,
      this.pnoresi,
      this.fname,
      this.pnoresi1,
      this.mname,
      this.pnoresi2,
      this.address,
      this.address1,
      this.address2,
      this.houserent,
      this.geo,
      this.ogeo,
      this.bba,
      this.pgramo,
      this.intert,
      this.rname,
      this.upp4,
      this.oaddress,
      this.oaddress1,
      this.oaddress2,
      this.refpno,
      this.rdate,
      this.area,
      this.dob,
      this.gi1,
      this.gg1,
      this.gi2,
      this.g2,
      this.upp1,
      this.upp2,
      this.upp3,
      this.lmark,
      this.rrname,
      this.mfin,
      this.nname,
      this.npno,
      this.nspname,
      this.npnoresi,
      this.nfname,
      this.npnoresi1,
      this.nmname,
      this.npnoresi2,
      this.naddress,
      this.naddress1,
      this.naddress2,
      this.nhouserent,
      this.ngeo,
      this.nbba,
      this.npgramo,
      this.nintert,
      this.nrname,
      this.nupp4,
      this.noaddress,
      this.noaddress1,
      this.noaddress2,
      this.nrefpno,
      this.narea,
      this.ndob,
      this.ngi1,
      this.ngg1,
      this.ngi2,
      this.ng2,
      this.nupp1,
      this.nupp2,
      this.nupp3,
      this.nlmark,
      this.nrrname,
      this.geooff,
      this.sname,
      this.spnoresi2,
      this.dname,
      this.dpnoresi2,
      this.cage,
      this.gage,
      this.designation});

  getcus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hpl = json['hpl'];
    hplt = json['hplt'];
    name = json['name'];
    pno = json['pno'];
    spname = json['spname'];
    pnoresi = json['pnoresi'];
    fname = json['fname'];
    pnoresi1 = json['pnoresi1'];
    mname = json['mname'];
    pnoresi2 = json['pnoresi2'];
    address = json['address'];
    address1 = json['address1'];
    address2 = json['address2'];
    houserent = json['houserent'];
    geo = json['geo'];
    ogeo = json['ogeo'];
    bba = json['bba'];
    pgramo = json['pgramo'];
    intert = json['intert'];
    rname = json['rname'];
    upp4 = json['upp4'];
    oaddress = json['oaddress'];
    oaddress1 = json['oaddress1'];
    oaddress2 = json['oaddress2'];
    refpno = json['refpno'];
    rdate = json['rdate'];
    area = json['area'];
    dob = json['dob'];
    gi1 = json['gi1'];
    gg1 = json['gg1'];
    gi2 = json['gi2'];
    g2 = json['g2'];
    upp1 = json['upp1'];
    upp2 = json['upp2'];
    upp3 = json['upp3'];
    lmark = json['lmark'];
    rrname = json['rrname'];
    mfin = json['mfin'];
    nname = json['nname'];
    npno = json['npno'];
    nspname = json['nspname'];
    npnoresi = json['npnoresi'];
    nfname = json['nfname'];
    npnoresi1 = json['npnoresi1'];
    nmname = json['nmname'];
    npnoresi2 = json['npnoresi2'];
    naddress = json['naddress'];
    naddress1 = json['naddress1'];
    naddress2 = json['naddress2'];
    nhouserent = json['nhouserent'];
    ngeo = json['ngeo'];
    nbba = json['nbba'];
    npgramo = json['npgramo'];
    nintert = json['nintert'];
    nrname = json['nrname'];
    nupp4 = json['nupp4'];
    noaddress = json['noaddress'];
    noaddress1 = json['noaddress1'];
    noaddress2 = json['noaddress2'];
    nrefpno = json['nrefpno'];
    narea = json['narea'];
    ndob = json['ndob'];
    ngi1 = json['ngi1'];
    ngg1 = json['ngg1'];
    ngi2 = json['ngi2'];
    ng2 = json['ng2'];
    nupp1 = json['nupp1'];
    nupp2 = json['nupp2'];
    nupp3 = json['nupp3'];
    nlmark = json['nlmark'];
    nrrname = json['nrrname'];
    geooff = json['geooff'];
    sname = json['sname'];
    spnoresi2 = json['spnoresi2'];
    dname = json['dname'];
    dpnoresi2 = json['dpnoresi2'];
    cage = json['cage'];
    gage = json['gage'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hpl'] = this.hpl;
    data['hplt'] = this.hplt;
    data['name'] = this.name;
    data['pno'] = this.pno;
    data['spname'] = this.spname;
    data['pnoresi'] = this.pnoresi;
    data['fname'] = this.fname;
    data['pnoresi1'] = this.pnoresi1;
    data['mname'] = this.mname;
    data['pnoresi2'] = this.pnoresi2;
    data['address'] = this.address;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['houserent'] = this.houserent;
    data['geo'] = this.geo;
    data['ogeo'] = this.ogeo;
    data['bba'] = this.bba;
    data['pgramo'] = this.pgramo;
    data['intert'] = this.intert;
    data['rname'] = this.rname;
    data['upp4'] = this.upp4;
    data['oaddress'] = this.oaddress;
    data['oaddress1'] = this.oaddress1;
    data['oaddress2'] = this.oaddress2;
    data['refpno'] = this.refpno;
    data['rdate'] = this.rdate;
    data['area'] = this.area;
    data['dob'] = this.dob;
    data['gi1'] = this.gi1;
    data['gg1'] = this.gg1;
    data['gi2'] = this.gi2;
    data['g2'] = this.g2;
    data['upp1'] = this.upp1;
    data['upp2'] = this.upp2;
    data['upp3'] = this.upp3;
    data['lmark'] = this.lmark;
    data['rrname'] = this.rrname;
    data['mfin'] = this.mfin;
    data['nname'] = this.nname;
    data['npno'] = this.npno;
    data['nspname'] = this.nspname;
    data['npnoresi'] = this.npnoresi;
    data['nfname'] = this.nfname;
    data['npnoresi1'] = this.npnoresi1;
    data['nmname'] = this.nmname;
    data['npnoresi2'] = this.npnoresi2;
    data['naddress'] = this.naddress;
    data['naddress1'] = this.naddress1;
    data['naddress2'] = this.naddress2;
    data['nhouserent'] = this.nhouserent;
    data['ngeo'] = this.ngeo;
    data['nbba'] = this.nbba;
    data['npgramo'] = this.npgramo;
    data['nintert'] = this.nintert;
    data['nrname'] = this.nrname;
    data['nupp4'] = this.nupp4;
    data['noaddress'] = this.noaddress;
    data['noaddress1'] = this.noaddress1;
    data['noaddress2'] = this.noaddress2;
    data['nrefpno'] = this.nrefpno;
    data['narea'] = this.narea;
    data['ndob'] = this.ndob;
    data['ngi1'] = this.ngi1;
    data['ngg1'] = this.ngg1;
    data['ngi2'] = this.ngi2;
    data['ng2'] = this.ng2;
    data['nupp1'] = this.nupp1;
    data['nupp2'] = this.nupp2;
    data['nupp3'] = this.nupp3;
    data['nlmark'] = this.nlmark;
    data['nrrname'] = this.nrrname;
    data['geooff'] = this.geooff;
    data['sname'] = this.sname;
    data['spnoresi2'] = this.spnoresi2;
    data['dname'] = this.dname;
    data['dpnoresi2'] = this.dpnoresi2;
    data['cage'] = this.cage;
    data['gage'] = this.gage;
    data['designation'] = this.designation;
    return data;
  }
}
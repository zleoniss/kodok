CameraRot() {
    static rot := false, init := OnExit((*) => rot && send("{" RotDown " 4}"), -1)
    send "{" RotUp " 12}"
    rot := true
}

Move(Dir, Dis, Dir2:="") {
	DirType := (Dir2!="")
	send "{" %Dir%Key " down}"
	if (DirType)
		send "{" %Dir2%Key " down}"
	Walk(Dis)
	send "{" %Dir%Key " up}"
	if (DirType)
		send "{" %Dir2%Key " up}"
}

Terra := (size=0.25) ? 4
	: (size=0.5) ? 6
	: (size=1) ? 8 
	: ( size=1.5) ? 10 :12
Grim := (size=0.25 || size=0.5) ? 1
	: (size=1 || size=1.5) ? 2 : 3
Kodoku := 0
itai := 0

CameraRot()
if (!FieldDriftCheck) {
	Move("AFCLR", 7, "AFCFB")
	Move("AFCFB", 3)
	Move("TCLR", 2, "TCFB")
	Move("TCLR", 1)
}
loop reps {
	Kodoku := Mod(Kodoku, 6) + 1
	if (Kodoku <= 3) {
		Move("TCLR", Terra)
		Move("TCFB", 8)
		loop Grim {
			Move("AFCLR", 2)
			Move("AFCFB", 6)
			Move("AFCLR", 2)
			Move("TCFB", 6)
		}
		Move("AFCLR", 2)
		Move("AFCFB", 7.8)
		if (size!=0.5 && size!=1.5) {
			Move("TCLR", 2)
		}
	} 
	else {
		loop Grim {
			if (size!=0.5 && size!=1.5 && itai=0) {
				Move("TCFB", 6)
				Move("TCLR", 2)
				Move("AFCFB", 6)
				Move("TCLR", 2)
			} else {
				Move("TCLR", 2)
				Move("TCFB", 6)
				Move("TCLR", 2)
				Move("AFCFB", 6)
			}
		}
		if (itai=1 || size=0.5 || size=1.5) {
			Move("TCLR", 2)
		}
		Move("TCFB", 8)
		if (size!=0.5 && size!=1.5 && itai=1) {
			Move("AFCLR", 2)
		}
		if (size=1 || size=2) {
			Move("AFCLR", 2)
		}
		Move("AFCLR", Terra)
		Move("AFCFB", 8)
		itai:=1
	}
}
for ecut in 20 22 24 26 30 35 40 45 50 55 60 65 70 75 80; do
    cat > ecut.$ecut.in << EOF
    &CONTROL
calculation  = 'scf'
pseudo_dir   = '../pseudo/'
outdir       = '../tmp/'
prefix       = 'gr'
/
    &SYSTEM
ibrav        = 4
a            = 2.4623
c            = 10.0
nat          = 2
ntyp         = 1
occupations  = 'smearing'
smearing     = 'mv'
degauss      = 0.02
ecutwfc      = ${ecut}
/
    &ELECTRONS
mixing_beta  = 0.7
conv_thr     = 1.0D-6
/
ATOMIC_SPECIES
 C 12.0107 C.pbe-n-rrkjus_psl.0.1.UPF

ATOMIC_POSITIONS (crystal)
 C  0.333333333  0.666666666  0.500000000
 C  0.666666666  0.333333333  0.500000000

K_POINTS (automatic)
 12 12 1 0 0 0

EOF
	pw.x <ecut.$ecut.in> ecut.$ecut.out
	echo " completed pw.x ecut = $ecut"
	awk '/!/ {printf"%d %s\n",'$ecut',$5}' ecut.$ecut.out >> calc-ecut.dat
done


#------------------------------------------------------------------------------
# Project 'FB_ZVS_PS_funcional_23_05_cod' make using the 'GFortran 4.2.1' compiler.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# All project
#------------------------------------------------------------------------------

all: targets
	@echo !--Make: succeeded.



#------------------------------------------------------------------------------
# Directories, Platform, and Version
#------------------------------------------------------------------------------

Arch        = windows
EmtdcDir    = C:\PROGRA~2\PSCAD45\emtdc\gf42
EmtdcInc    = $(EmtdcDir)\inc
EmtdcBin    = $(EmtdcDir)\$(Arch)
EmtdcMain   = $(EmtdcBin)\main.obj
EmtdcLib    = $(EmtdcBin)\emtdc.lib


#------------------------------------------------------------------------------
# Fortran Compiler
#------------------------------------------------------------------------------

FC_Name     = gfortran.exe
FC_Suffix   = o
FC_Args     = -c -ffree-form -fdefault-real-8
FC_Debug    = 
FC_Warn     = 
FC_Checks   = 
FC_Includes = -I"$(EmtdcInc)" -I"$(EmtdcBin)"
FC_Compile  = $(FC_Name) $(FC_Args) $(FC_Includes) $(FC_Debug) $(FC_Warn) $(FC_Checks)

#------------------------------------------------------------------------------
# C Compiler
#------------------------------------------------------------------------------

CC_Name     = gcc.exe
CC_Suffix   = o
CC_Args     = -c
CC_Debug    = 
CC_Includes = -I"$(EmtdcInc)" -I"$(EmtdcBin)"
CC_Compile  = $(CC_Name) $(CC_Args) $(CC_Includes) $(CC_Debug)

#------------------------------------------------------------------------------
# Linker
#------------------------------------------------------------------------------

Link_Name   = gcc.exe
Link_Debug  = 
Link_Args   = -o $@
Link        = $(Link_Name) $(Link_Args) $(Link_Debug)

#------------------------------------------------------------------------------
# Build rules for generated files
#------------------------------------------------------------------------------


%.$(FC_Suffix): %.f
	@echo !--Compile: $<
	$(FC_Compile) $<


%.$(CC_Suffix): %.c
	@echo !--Compile: $<
	$(CC_Compile) $<



#------------------------------------------------------------------------------
# Build rules for file references
#------------------------------------------------------------------------------


user_source_1.$(CC_Suffix): C:\Users\Leonan\GOOGLE~1\UFRJ\PROJET~1\SIMULA~1\PSCad\\source\CONTRO~1.C
	@echo !--Compile: "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\\source\controle_FB-ZVS-PS2.c"
	copy "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\\source\controle_FB-ZVS-PS2.c" .
	$(CC_Compile) "controle_FB-ZVS-PS2.c"
	del "controle_FB-ZVS-PS2.c"

user_source_2.$(CC_Suffix): C:\Users\Leonan\GOOGLE~1\UFRJ\PROJET~1\SIMULA~1\PSCad\\source\PIDTRA~1.C
	@echo !--Compile: "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\\source\PIDtransformadaZPontoFixo2_corrigido.c"
	copy "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\\source\PIDtransformadaZPontoFixo2_corrigido.c" .
	$(CC_Compile) "PIDtransformadaZPontoFixo2_corrigido.c"
	del "PIDtransformadaZPontoFixo2_corrigido.c"

#------------------------------------------------------------------------------
# Dependencies
#------------------------------------------------------------------------------


FC_Objects = \
 Station.$(FC_Suffix) \
 Main.$(FC_Suffix)

FC_ObjectsLong = \
 "Station.$(FC_Suffix)" \
 "Main.$(FC_Suffix)"

CC_Objects = \
  user_source_1.$(CC_Suffix) \
  user_source_2.$(CC_Suffix)

CC_ObjectsLong = \
  "controle_FB-ZVS-PS2.$(CC_Suffix)" \
  "PIDtransformadaZPontoFixo2_corrigido.$(CC_Suffix)"

UserLibs =

SysLibs  = -lgfortran -lstdc++ -lwsock32

Binary   = FB_ZVS_PS_funcional_23_05_cod.exe

$(Binary): $(FC_Objects) $(CC_Objects) $(UserLibs)
	@echo !--Link: $@
	$(Link) "$(EmtdcMain)" $(FC_ObjectsLong) $(CC_ObjectsLong) $(UserLibs) "$(EmtdcLib)" $(SysLibs)

targets: $(Binary)


clean:
	-del EMTDC_V*
	-del *.obj
	-del *.o
	-del *.exe
	@echo !--Make clean: succeeded.




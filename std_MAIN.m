%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               % 
%         Script Template - standard stream                     %
%                                                               %                                            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Stream order: eeglab -> flags -> os -> paraset -> mod -> import ->
% -> elist -> binlis ->chanloc -> epoch -> addeye -> artif -> eegrefch(optional: For EEGLab processing only)-> avg -> erprefch -> meas -> gavg(with lp)
% Optional stream order: Filter (all steps but add filter before meas), CAR (all steps but also reref to CAR in addition to M12), eegrefch (for EEGLab processing only),
% Fixed order: elist -> binlis; commands after this until avg step can change order by moving commands below into new order; commands from avg onwards fixed order
% Save Command Window output text to a created file 

global os_paraset mod import elist binlis chanloc epoch  addeye artif artif_all artif_one 

diary('C:\Users\pzhao\Documents\MATLAB\standard11\diary11.txt'); %***Modify to yours ***%

                 %*****************************%%      *** set clr = 0 if have run some functions and stop in the middle.
                 %          Stage 1            %       % otherwise it will clear all the values generated by the functions in the workspace.
                 %*****************************%       

clr = 0;

if clr
    std_clear;
end

%need to run eeglab first
eeglab

% Set up Global flags & ERP flags
std_flags;

% Choose Operating systems & user's paths & set up parameters
if os_paraset
    std_os_paraset; 
end

%MODULES BELOW: Load and save each step
if mod
    std_mod; 
end

%Import and translate BioSemi/Raw Data into EEGLab .set only once.
if import
    std_import
end

% Creates ERP Eventlist
if elist 
   std_elist
end

% Assign bins (Binlister);ADD RT OUTPUT FLAGS
if binlis
   std_binlis
end

% Add Channel Locations
if chanloc  
   std_chanloc
end

%Create Bin based Epoch
if epoch
   std_epoch
end

%Add Channels for Artifact Detection. Also Copy LE and Fp2 to end
if addeye
   std_addeye
end

%Artifact Detection & artifact-free average
if artif
   std_artif
end

                %********************** Stage 2 ********************%
                %      please set 'clr' to  0;                      %
                %      modify the artif_S.. for each subject;       %
                %      change the flags at stage 1 equal to 0;      %
                %      change the flags at stage 2 equal to 1;      %
                %      then run MAIN.m again;                       %
                %***************************************************%
                
if artif_one    %run single subject
    std_artif_one
end

% This is optional now. Run all subjects in one go
if artif_all    
    std_artif_all
end

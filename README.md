
<img src="https://github.com/nataliering/Strep_methylation/blob/main/strep_methylation_logo.png" width="600" class="center" title="Pipeline logo" alt="Pipeline logo"/>

# From pod5s to motif discovery

## How to use 
1. Download and untar Dorado v0.9.6                                                                                                                                                                                                                                        
`wget https://cdn.oxfordnanoportal.com/software/analysis/dorado-0.9.6-linux-x64.tar.gz`                                                                                    
`tar -zxvf dorado-0.9.6-linux-x64.tar.gz`                                                                                                                                                                                                                                          

2. Download and install our Conda environment from basecalling_to_motif.yml                                                                                                                                                                               
`git clone https://github.com/nataliering/Strep_methylation.git`                                                                                                                                                                                               
`cd Strep_methylation`                                                                                                                                                                                                                       
`mamba env create -f basecalling_to_motif.yml`                                                                                                                                                                                            

3. Open basecalling_to_motif.sh and edit necessary paths and file names (noted in the script by "# CHANGE")

4. Make basecalling_to_motif.sh executable                                                                                                                                    
`chmod 700 basecalling_to_motif.sh`                                                                                                                                                                                                                                                                

6. Run basecalling_to_motif.sh!                                                                                                                                                                                                                         
`/path/to/Strep_methylation/basecalling_to_motif.sh`                                                                                                                                                                                                                  

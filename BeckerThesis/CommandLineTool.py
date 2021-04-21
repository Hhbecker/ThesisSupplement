#!/usr/bin/env python
# coding: utf-8

# ## A command line tool for GTDB-tk (Genome Taxonomy Database Toolkit) output tree interpretation
# 
# Author: Henry Becker 
# Date: April 2021

# Program Inputs
# input 1: GTDB-tk tree (in newick format)
# input 2: Clade name you want a subtree of
# 
# Program Functions
# 1. loads tree
# 2. roots tree
# 3. detaches subtree of input clade
# 4. downloads NCBI metadata relevant columns 
# 5. cleans metadata columns
# 6. cleans tree leaf names
# 7. replaces each leaf with organism name from NCBI metadata table (if available)
# 8. writes new tree file to working directory (with title of clade name) 
# 9. prints tree summary with number of nodes of old and new tree

# In[23]:


import os 
import ete3
from ete3 import Tree
import pandas as pd 
import numpy as np
import sys


# In[24]:


# Take first parameter passed in by user from command line 
inFile = sys.argv[1]
cladeName = sys.argv[2]
#binIdentifier = sys.argv[3]

# Make sure input file is a tree if it isn't print error message 


# In[56]:


#os.chdir("")
#inFile = ""


# In[57]:


# Read input file as tree
tree = ete3.PhyloTree(inFile, quoted_node_names=True, format=1) 


# In[58]:


# If the tree is unrooted root node has 3 children - root tree

# Calculate the midpoint outgroup node
r = tree.get_midpoint_outgroup()
# Set that node as outgroup
tree.set_outgroup(r)


# In[59]:


# first letter must be caps
nodeFound = False

for node in tree.traverse():
    if cladeName in node.name:
        keyNode = node
        nodeFound = True
        print(cladeName, "found, detaching subtree...")
        subtree = keyNode.detach()
        break 

if nodeFound == False:
    print("Clade not found. Check the GTDB website (https://gtdb.ecogenomic.org/tree?r=d__Bacteria) for the proper clade name (May differ from NCBI taxonomy).")
    print("Remember to capitalize first letter of clade name.")
    print("Program exiting.")
    sys.exit()


# In[29]:


# This codeblock reads in the NCBI assembly metadata columns needed 
url = "https://ftp.ncbi.nlm.nih.gov/genomes/ASSEMBLY_REPORTS/assembly_summary_genbank.txt" #NCBI assembly metadata table link

# NOTE: there is a difference between 'species_taxid' (strain level) and 'taxid' (species level). 
# The strain level taxid variable is imported here. See ftp://ftp.ncbi.nlm.nih.gov/genomes/README_assembly_summary.txt for more info.
colFields = ['# assembly_accession', 'species_taxid', 'organism_name']
dtypeFields = {'# assembly_accession': str, 'taxid': int, 'organism_name': str}
colnames = ['accession', 'taxid', 'organism_name']

# Currently reading only relevant columns though other columns may be of use in future implementations)
tbl = pd.read_csv(url, sep='\t', header=1, usecols=[0,5,7], dtype=dtypeFields, names=colnames)


# *The functions below are not foolproof* - If NCBI changes the format of their assembly accessions or if GTDB-tk changes the format of their tree leaf names the functions below will need to be updated accordingly.

# In[60]:


# This function cleans the end of the assembly accession string from the metadata table so that it matches 
# with the accessions found in the GTDB-tk tree. The metadata table has a specific suffix for every assembly 
# (organism/strain level) of a given species but the GTDB-tk does not get more specific than the species level. 

# Input: metadata table 'accession' column with suffixes 
# Returns: metadata table 'accession' column without suffixes
def clean2(name):
    firstSplit = name.split(".", 1)
    newName = firstSplit[0]
    return newName

# Calls the function defined above 
tbl['accession'] = tbl['accession'].map(clean2)


# In[61]:


# This function cleans the GTDB identifiers added as prefixes to NCBI assembly accession numbers. Once the leaves 
# are cleaned using this function they will match up with the NCBI metadata table 'accession' column.

#Input: GTDB-tk tree leaf node.name string
#Returns: new leaf name without GTDB prefix  
def clean1(name):
    firstSplit = name.split("_", 1)
    secondSplit = firstSplit[1].split(".", 1)
    newName = secondSplit[0]
    return newName


# In[ ]:


subtree.ladderize()
subtree.render("treeImageSameNames.png")
subtree.write(format=1, outfile="newTreeSameNames.nw")


# In[71]:


#this loop makes taxid leaf name


total = 0
changes = 0

for node in subtree.traverse():
    if node.is_leaf():
        total +=1
        if "bin" in node.name:
            node.name = node.name + " ####" # add a tag to bins so they are 
        if "bin" not in node.name:
            node.name = clean1(node.name) # cleans prefix and suffix of leaf names to match with NCBI metadata
            # The lines below create a series of organism names where the accession matches the leaf name and assigns the first to the leaf
            series = tbl.loc[tbl['accession'] == node.name, 'organism_name'] #w as taxid
            if len(series)>0:
                node.name = series.iloc[0]
                changes +=1
                if changes < 20:
                    print(node.name)
            
print("Subtree has", total, "leaves. Species names were added to", changes, "leaves.")


# In[58]:


subtree.ladderize()
subtree.render("treeImageNewNames.png")
subtree.write(format=1, outfile="newTreeNewNames.nw")


# In[ ]:


print("-program complete-")


# In[ ]:





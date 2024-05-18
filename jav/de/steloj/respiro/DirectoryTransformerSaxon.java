//  #**************************************************************************
//  #
//  #    $Id$
//  #
//  #    Copyright (C) 2006-2020  Wolfram Diestel
//  #
//  #    This program is free software; you can redistribute it and/or modify
//  #    it under the terms of the GNU General Public License as published by
//  #    the Free Software Foundation; either version 2 of the License, or
//  #    (at your option) any later version.
//  #
//  #    This program is distributed in the hope that it will be useful,
//  #    but WITHOUT ANY WARRANTY; without even the implied warranty of
//  #    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  #    GNU General Public License for more details.
//  #
//  #    You should have received a copy of the GNU General Public License
//  #    along with this program; if not, write to the Free Software
//  #    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//  #
//  #    Send comments and bug fixes to diestel@steloj.de
//  #
//  #**************************************************************************/

package de.steloj.respiro;


import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.File;
import java.util.Map;
import java.util.HashMap;

import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.XsltCompiler;
import net.sf.saxon.s9api.XsltExecutable;
import net.sf.saxon.s9api.XsltTransformer;
import net.sf.saxon.s9api.Serializer;
import net.sf.saxon.s9api.SaxonApiException;
import net.sf.saxon.s9api.QName;
import net.sf.saxon.s9api.XdmValue;
import net.sf.saxon.s9api.XdmAtomicValue;

import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.OutputKeys;
//import javax.xml.stream.XMLStreamWriter;
//import javax.xml.transform.stream.StreamResult;


//import javax.xml.transform.Transformer;
//import javax.xml.transform.TransformerConfigurationException;
//import javax.xml.transform.TransformerException;
//import javax.xml.transform.TransformerFactory;


public class DirectoryTransformerSaxon {

	static boolean verbose = false;
	static Map<String, String> params = new HashMap<String, String>();
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int i=0;
		
		// options
		while (args[i].charAt(0)=='-') {
			if (args[i].equals("-v")) {
				verbose = true;
			} else if (args[i].equals("-p")) {
				// XSL parametroj por "transformer" - vd. malsupre
				i++;
				String[] kval = args[i].split("=");
				if (kval.length == 2) {
					params.put(kval[0],kval[1]);
				}
			}
			i++;
		}
		
		final String pathname = args[i];
		final String stylesheet = args[i+1];	
		final String outfilename = args[i+2];
		
		final String rootTag; 
		if (args.length>i+3)
			rootTag = args[i+3];
		else
			rootTag = "xml";
		
		try {
			transformDir(pathname,stylesheet,outfilename,rootTag);
		} catch (Exception e) {
			System.out.print(e);
		}
	}
	
	public static void transformDir(String pathname, String style, String outfilename, String rootTag) 
	throws SaxonApiException, FileNotFoundException, IOException {

  		// Prepare transformer
		Processor processor = new Processor(false);
		XsltCompiler compiler = processor.newXsltCompiler();
		XsltExecutable stylesheet = compiler.compile(new StreamSource(style));
		XsltTransformer transformer = stylesheet.load();
		//transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION,"yes");	
		
		// transdonu XSL parametrojn
		// https://www.saxonica.com/html/documentation/javadoc/net/sf/saxon/s9api/XsltTransformer.html#setParameter-net.sf.saxon.s9api.QName-net.sf.saxon.s9api.XdmValue-
			
			for (Map.Entry<String, String> par : params.entrySet()) {
			transformer.setParameter(
				new QName(par.getKey()),
				new XdmAtomicValue(par.getValue()));
		}

		File inpath = new File(pathname);		

		FileOutputStream outfile = new FileOutputStream(outfilename);		
		String start = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"+
			"<"+rootTag+">";
		String end = "</"+rootTag+">";	
		outfile.write(start.getBytes());
		
		Serializer out = new Serializer();
		out.setOutputProperty(Serializer.Property.METHOD, "xml");
		out.setOutputProperty(Serializer.Property.INDENT, "yes");
		out.setOutputProperty(Serializer.Property.OMIT_XML_DECLARATION,"yes");			

		out.setOutputStream(outfile);
		transformer.setDestination(out);

		File[] files = inpath.listFiles();

		for (int i=0; i<files.length; i++) {
			File file = files[i];
			
			if (file.isFile()) {
				if (verbose) System.err.println(file.getName()+"...");
			
				transformer.setSource(new StreamSource(file));
				transformer.transform(); 
			}
		}
		
		outfile.write(end.getBytes());
		outfile.flush();
		outfile.close();
	}

}

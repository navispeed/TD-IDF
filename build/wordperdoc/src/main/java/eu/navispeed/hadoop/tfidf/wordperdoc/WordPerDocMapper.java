package eu.navispeed.hadoop.tfidf.wordperdoc;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;

import java.io.IOException;
import java.util.StringTokenizer;

public class WordPerDocMapper extends Mapper<LongWritable, Text, Text, IntWritable> {

    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();

    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        String docId;

        docId = ((FileSplit) context.getInputSplit()).getPath().getName();


        StringTokenizer tokenizer = new StringTokenizer(line);
        while (tokenizer.hasMoreTokens()) {
            final String string = tokenizer.nextToken().replaceAll("[^A-Za-z]", "").toLowerCase().trim();
            if (string.length() < 3) {
                continue;
            }
            word.set(string + "," + docId);
            context.write(word, one);
//            context.write(new TupleWritable(new Writable[]{word, new Text(docId)}), one);
        }
    }

    public void run(Context context) throws IOException, InterruptedException {
        setup(context);
        while (context.nextKeyValue()) {
            map(context.getCurrentKey(), context.getCurrentValue(), context);
        }
        cleanup(context);
    }

}
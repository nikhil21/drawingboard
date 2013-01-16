package com.drawingboard

import com.drawingboard.common.Constants
import com.drawingboard.server.QueueCO
import com.drawingboard.server.QueueBL
import gui.ava.html.image.generator.HtmlImageGenerator
import java.awt.image.BufferedImage
import com.sun.image.codec.jpeg.JPEGCodec
import com.sun.image.codec.jpeg.JPEGImageEncoder
import javax.swing.JLabel
import java.awt.Graphics
import java.awt.Color
import javax.imageio.ImageIO
import java.awt.Graphics2D
import java.awt.Image
import javax.imageio.ImageReadParam
import javax.imageio.stream.ImageInputStream
import javax.imageio.ImageReader

class SchedulerController {

    def index = { }
    def main = {
        println "params are ${params}"
        List<Department> departmentList = Department.list()
        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
        List<Machine> machineList = [];
        Machine futureWork = null
        // if there is a current department then only try to get the Machines
        if (currentDepartment) {
            // if no id is passed, default to the first department
            machineList = Machine.findAllByDepartmentAndNameNotEqual(currentDepartment, Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
            // pass the Future Work Machine explicitly
            futureWork = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
        }

        render(view:  'main1', model: [departmentID:currentDepartment.id,departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    def main2 = {
        println "params are ${params}"
        List<Department> departmentList = Department.list()
        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
        List<Machine> machineList = [];
        Machine futureWork = null
        // if there is a current department then only try to get the Machines
        if (currentDepartment) {
            // if no id is passed, default to the first department
            machineList = Machine.findAllByDepartmentAndNameNotEqual(currentDepartment, Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
            // pass the Future Work Machine explicitly
            futureWork = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
        }

        render(view:  'main2', model: [departmentID:currentDepartment.id,departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    def update = {
        //params.each{ println "::"+it }

        List<Queue> queueList = Queue.findAllByMachineInList(Machine.findAllByDepartment(Department.get(params.int('departmentID'))))
        String departmentID;
        Department department;
        Machine machine;
        queueList.each{ Queue queue ->
            QueueCO queueCO = new QueueCO();
            bindData(queueCO, params["queue-${queue.id}"])

            if (params["queue_${queue.id}.departmentChange"] && params["queue_${queue.id}.departmentID"]){
                departmentID = params["queue_${queue.id}.departmentID"];
                department = Department.findById(Integer.parseInt(departmentID))
                machine = Machine.findByDepartmentAndNameIlike(department,Constants.FUTRE_WORK_MACHINE_NAME+"%")

                if (machine){
                    queueCO.machine=machine
                }
                println "\n::::after binding1::::"+queueCO
            } else{
                println "\n::::after binding2::::"+queueCO
            }

            if(queue.id!=null){
                QueueBL bl = new QueueBL()
                bl.saveQueue(queueCO)
            }
        }

        redirect(action:'main2', params:[departmentID:params.int('departmentID')])
    }

    def print = {
        println ">>>>>>>>>>>>>"+params
        HtmlImageGenerator imageGenerator = new HtmlImageGenerator();
//        imageGenerator.loadUrl("http://www.yahoo.com/")
//        imageGenerator.loadUrl("http://localhost:8080/scheduler/scheduler/main2")
//        imageGenerator.getLinks();
        String html =getUrlString("http://localhost:8080/scheduler/scheduler/main2")
        println html
        imageGenerator.loadHtml(html)
        imageGenerator.saveAsImage("jpg.jpg");
        imageGenerator.saveAsHtmlWithMap("jpg.html", "jpg.jpg")
        imageGenerator.saveAsImage("png.png");
        imageGenerator.saveAsHtmlWithMap("png.html", "png.png")
        BufferedImage bi = imageGenerator.getBufferedImage()
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(new FileOutputStream("screen.jpg"));
        encoder.encode(bi);
    }

    def print2 = {
        String html =getUrlSource("http://localhost:8080/scheduler/scheduler/main2")
//        String html =getUrlSource("http://www.yahoo.com/")
//        String html =getUrlString("http://www.yahoo.com/")

        byteArrayToImage2(html.getBytes())
    }

    public static String getUrlSource(String url) throws IOException {
        URL yahoo = new URL(url);
        URLConnection yc = yahoo.openConnection();
        BufferedReader br = new BufferedReader(new InputStreamReader(yc.getInputStream(), "UTF-8"));
        String inputLine;
        StringBuilder a = new StringBuilder();
        while ((inputLine = br.readLine()) != null)
        a.append(inputLine);
        br.close();

        return a.toString();
    }

    public static String getUrlString(String urlString){
        URL url;
        InputStream is = null;
        DataInputStream dis;
        String line;
        StringBuilder str = new StringBuilder();

        try {
            url = new URL(urlString);
            is = url.openStream();  // throws an IOException
            dis = new DataInputStream(new BufferedInputStream(is));

            while ((line = dis.readLine()) != null) {
                System.out.println(line);
                str.append(line);
            }
        } catch (MalformedURLException mue) {
            mue.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException ioe) {
                // nothing to see here
            }
        }

        return str.toString();
    }

    public static void byteArrayToImage1(byte[] bytes ){
        //Before is how to change ByteArray back to Image
        ByteArrayInputStream bis = new ByteArrayInputStream(bytes);
        Iterator<?> readers = ImageIO.getImageReadersByFormatName("jpg");
        //ImageIO is a class containing static convenience methods for locating ImageReaders
        //and ImageWriters, and performing simple encoding and decoding.

        ImageReader reader = (ImageReader) readers.next();
        Object source = bis; // File or InputStream, it seems file is OK

        ImageInputStream iis = ImageIO.createImageInputStream(source);
        //Returns an ImageInputStream that will take its input from the given Object

        reader.setInput(iis, true);
        ImageReadParam param = reader.getDefaultReadParam();

        Image image = reader.read(0, param);
        //got an image file

        BufferedImage bufferedImage = new BufferedImage(image.getWidth(null), image.getHeight(null), BufferedImage.TYPE_INT_RGB);
        //bufferedImage is the RenderedImage to be written
        Graphics2D g2 = bufferedImage.createGraphics();
        g2.drawImage(image, null, null);
        File imageFile = new File("newrose2.jpg");
        ImageIO.write(bufferedImage, "jpg", imageFile);
        //"jpg" is the format of the image
        //imageFile is the file to be written to.

        System.out.println(imageFile.getPath());
    }

    public static void byteArrayToImage2(byte[] bytes ){
        try {
            BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(bytes));
//            ImageIO.write(bufferedImage, "jpg", new File("image.jpg"));
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(new FileOutputStream("screen2.jpg"));
            encoder.encode(bufferedImage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

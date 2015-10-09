package com.googosoft.filesManager.course;

import java.io.File;

import com.googosoft.exception.ManagerException;
import com.googosoft.filesManager.course.FileManager;

public class DeleteFiles {
	/**
	 * 单例模式（懒汉）
	 * @param args
	 */
	private static DeleteFiles instance;

	private DeleteFiles() {

	}

	public static DeleteFiles getInstance() {
		if (instance == null) {
			instance = new DeleteFiles();
		}
		return instance;
	}
	/**   
     * 删除文件，可以是单个文件或文件夹   
     * @param   fileName    待删除的文件名   
     * @return 文件删除成功返回true,否则返回false   
     */    
    public static boolean delete(String fileName){     
        File file = new File(fileName);     
        if(!file.exists()){     
            System.out.println("删除文件失败："+fileName+"文件不存在");     
            return false;     
        }else{     
            if(file.isFile()){     
                     
                return deleteFile(fileName);     
            }else{     
                return deleteDirectory(fileName);     
            }     
        }     
    }     
         
    /**   
     * 删除单个文件   
     * @param   fileName    被删除文件的文件名   
     * @return 单个文件删除成功返回true,否则返回false   
     */    
    public static boolean deleteFile(String fileName){     
        File file = new File(fileName);     
        if(file.isFile() && file.exists()){     
            file.delete();     
            System.out.println("删除单个文件"+fileName+"成功！");     
            return true;     
        }else{     
            System.out.println("删除单个文件"+fileName+"失败！");     
            return false;     
        }     
    }     
         
    /**   
     * 删除目录（文件夹）以及目录下的文件   
     * @param   dir 被删除目录的文件路径   
     * @return  目录删除成功返回true,否则返回false   
     */    
    public static boolean deleteDirectory(String dir){     
        //如果dir不以文件分隔符结尾，自动添加文件分隔符     
        if(!dir.endsWith(File.separator)){     
            dir = dir+File.separator;     
        }     
        File dirFile = new File(dir);     
        //如果dir对应的文件不存在，或者不是一个目录，则退出     
        if(!dirFile.exists() || !dirFile.isDirectory()){     
            System.out.println("删除目录失败"+dir+"目录不存在！");     
            return false;     
        }     
        boolean flag = true;     
        //删除文件夹下的所有文件(包括子目录)     
        File[] files = dirFile.listFiles();     
        for(int i=0;i<files.length;i++){     
            //删除子文件     
            if(files[i].isFile()){     
                flag = deleteFile(files[i].getAbsolutePath());     
                if(!flag){     
                    break;     
                }     
            }     
            //删除子目录     
            else{     
                flag = deleteDirectory(files[i].getAbsolutePath());     
                if(!flag){     
                    break;     
                }     
            }     
        }     
             
        if(!flag){     
            System.out.println("删除目录失败");     
            return false;     
        }     
             
        //删除当前目录     
        if(dirFile.delete()){     
            System.out.println("删除目录"+dir+"成功！");     
            return true;     
        }else{     
            System.out.println("删除目录"+dir+"失败！");     
            return false;     
        }     
    }     
      public void judgeIds(String ids,String toPath) throws ManagerException{
    	  String[] idAll;
    	  if(ids.contains("','")){
    		  ids.replace("'", "");
    		  idAll = ids.split("','");
    		  for (int i = 0; i < idAll.length; i++) {
				FileManager fileManager = new FileManager();
				Object fileName = fileManager.findFileNameById(idAll[i]);
				Object extendName = fileManager.findExtendNameById(idAll[i]);
				if(".rm".equals(extendName)||".mp4".equals(extendName)||".flv".equals(extendName)||".rmvb".equals(extendName)){
					String fileDir0 = toPath+fileName+extendName;
					String fileDir1 = toPath+fileName+".flv";
					String fileDir2 = toPath+fileName+".jpg";
					delete(fileDir0);
					delete(fileDir1);
					delete(fileDir2);
				}else if(".pdf".equals(extendName)){
					String fileDir0 = toPath+fileName+extendName;
					String fileDir1 = toPath+fileName+".swf";
					delete(fileDir0);
					delete(fileDir1);
				}else{
					String fileDir0 = toPath+fileName+extendName;
					String fileDir1 = toPath+fileName+".swf";
					String fileDir2 = toPath+fileName+".pdf";
					delete(fileDir0);
					delete(fileDir1);
					delete(fileDir2);
				}
			}
    	  }else{
    		  	FileManager fileManager = new FileManager();
				Object fileName = fileManager.findFileNameById(ids);
				Object extendName = fileManager.findExtendNameById(ids); 
				if(".rm".equals(extendName)||".mp4".equals(extendName)||".flv".equals(extendName)||".rmvb".equals(extendName)){
					String fileDir0 = toPath+fileName+extendName;
					String fileDir1 = toPath+fileName+".flv";
					String fileDir2 = toPath+fileName+".jpg";
					delete(fileDir0);
					delete(fileDir1);
					delete(fileDir2);
				}else if(".pdf".equals(extendName)){
					String fileDir0 = toPath+fileName+extendName;
					String fileDir1 = toPath+fileName+".swf";
					delete(fileDir0);
					delete(fileDir1);
				}else{
					String fileDir0 = toPath+fileName+extendName;
					String fileDir1 = toPath+fileName+".swf";
					String fileDir2 = toPath+fileName+".pdf";
					delete(fileDir0);
					delete(fileDir1);
					delete(fileDir2);
				}
    	  }
      }   
}

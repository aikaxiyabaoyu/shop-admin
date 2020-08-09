package com.fh.shop.admin.util;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class Upload {

		//图片上传
		public static String uploadPoster(MultipartFile image,HttpServletRequest req){
			//路径
			String realPath = req.getSession().getServletContext().getRealPath("/images");
			//文件名
			String originalFilename = image.getOriginalFilename();
			//拼接之后的文件名
			String finalFileName = UUID.randomUUID().toString()+"-"+originalFilename;
			File fileTemp = new File(realPath);
			//判断是否存在文件夹
			if(!fileTemp.exists()){
				//创建文件夹
				fileTemp.mkdir();
			}
			File file = new File(realPath+"//"+finalFileName);
			//上传文件 用的mvc自带的上传方法
			try {
				image.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			return "/images/" + finalFileName;
		}

	//文件上传
	public static String uploadFile(MultipartFile file,HttpServletRequest req){
		//路径
		String realPath = req.getSession().getServletContext().getRealPath("/files");
		//文件名
		String originalFilename = file.getOriginalFilename();
		//拼接之后的文件名
		String finalFileName = UUID.randomUUID().toString()+"-"+originalFilename;
		File fileTemp = new File(realPath);
		//判断是否存在文件夹
		if(!fileTemp.exists()){
			//创建文件夹
			fileTemp.mkdir();
		}
		File f = new File(realPath+"//"+finalFileName);
		//上传文件 用的mvc自带的上传方法
		try {
			file.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return "/files/" + finalFileName;
	}

		//删除图片
		public static void deleteImage(String fileNames,HttpServletRequest request){
			if(!StringUtils.isEmpty(fileNames)){
				String realPath = request.getServletContext().getRealPath("/");

				String[] fileNameArr = fileNames.split(",");

				for(int i = 0; i<fileNameArr.length; i++){
					File file = new File(realPath + fileNameArr[i]);

					if(file.exists()){
						file.delete();
					}
				}
			}
		}

}


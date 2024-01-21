package com.umrah.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import com.umrah.dto.LoginRequest;
import com.umrah.dto.LoginResponse;
import com.umrah.dto.AdminRequest;
import com.umrah.dto.AdminResponse;
import com.umrah.dto.AgencyRequest;
import com.umrah.dto.AgencyResponse;
import com.umrah.dto.FilterRequest;
import com.umrah.dto.FilterResponse;
import com.umrah.service.UmrahService;

import jakarta.servlet.ServletContext;

@Controller
public class UmrahController {

	@Autowired
	UmrahService umrahService;

	@Autowired
	ServletContext context;
	
	@GetMapping( "/image/{imageName}")
    @ResponseBody
    public byte[] getImage(@PathVariable String imageName) throws IOException {
		BufferedImage bufferedImage = ImageIO.read(context.getResourceAsStream("/WEB-INF/resources/images/" + imageName));
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		ImageIO.write(bufferedImage, "png", byteArrayOutputStream);
		
        return byteArrayOutputStream.toByteArray();
    }
	
	@GetMapping("/")
	public String indexPage() {
		return "index";
	}
	
	@GetMapping("/filter")
	public String filterPage() {
		return "filter";
	}
	
	@GetMapping("/filters/page")
	public String filtersPage() {
		return "filters";
	}
	
	@GetMapping("/admin/login/page")
	public String adminLoginPage() {
		return "admin_login";
	}
	
	@GetMapping("/admins/page")
	public String viewAdminsPage() {
		return "admins";
	}
	
	@GetMapping("/admin/page")
	public String viewAdminPage() {
		return "admin";
	}
	
	@GetMapping("/agency/page")
	public String viewAgencyPage() {
		return "agency";
	}
	
	@GetMapping("/admins")
	@ResponseBody
	public List<AdminResponse> getAdmins() {
		return umrahService.getAdmins();
	}
	
	@GetMapping("/admin/{adminId}")
	@ResponseBody
	public AdminResponse getAdminByAdminId(@PathVariable("adminId") String adminId) {
		return umrahService.getAdminByAdminId(adminId);
	}
	
	@PostMapping("/admin/login")
	@ResponseBody
	public LoginResponse loginTeacher(@RequestPart(value="loginRequest") LoginRequest loginRequest) {
		return umrahService.adminLogin(loginRequest);
	}
	
	@PostMapping("/admin")
	@ResponseBody
	public AdminResponse insertAdmin(@RequestPart(value="adminRequest") AdminRequest adminRequest) {
		return umrahService.insertAdmin(adminRequest);
	}
	
	@PutMapping("/admin")
	@ResponseBody
	public AdminResponse updateAdmin(@RequestPart(value="adminRequest") AdminRequest adminRequest) {
		return umrahService.updateAdmin(adminRequest);
	}
	
	@DeleteMapping("/admin/{adminId}")
	@ResponseBody
	public Boolean deleteAdminByAdminId(@PathVariable("adminId") String adminId) {
		return umrahService.deleteAdminByAdminId(adminId);
	}
	
	@GetMapping("/agencies")
	@ResponseBody
	public List<AgencyResponse> getAgencies() {
		return umrahService.getAgencies();
	}
	
	@GetMapping("/agency/{agencyId}")
	@ResponseBody
	public AgencyResponse getAgencyByAgencyId(@PathVariable("agencyId") String agencyId) {
		return umrahService.getAgencyByAgencyId(agencyId);
	}
	
	@GetMapping("/agency/admin/{adminId}")
	@ResponseBody
	public AgencyResponse getAgencyByAdminId(@PathVariable("adminId") String adminId) {
		return umrahService.getAgencyByAdminId(adminId);
	}
	
	@PostMapping("/agency")
	@ResponseBody
	public AgencyResponse insertAgency(@RequestPart(value="agencyRequest") AgencyRequest agencyRequest) {
		return umrahService.insertAgency(agencyRequest);
	}
	
	@PutMapping("/agency")
	@ResponseBody
	public AgencyResponse updateAgency(@RequestPart(value="agencyRequest") AgencyRequest agencyRequest) {
		return umrahService.updateAgency(agencyRequest);
	}
	
	@DeleteMapping("/agency/{agencyId}")
	@ResponseBody
	public Boolean deleteAgencyByAgencyId(@PathVariable("agencyId") String agencyId) {
		return umrahService.deleteAgencyByAgencyId(agencyId);
	}
	
	@GetMapping("/filters")
	@ResponseBody
	public List<FilterResponse> getFilters() {
		return umrahService.getFilters();
	}
	
	@PostMapping("/filter")
	@ResponseBody
	public FilterResponse insertFilter(@RequestPart(value="filterRequest") FilterRequest filterRequest) {
		return umrahService.insertFilter(filterRequest);
	}
}

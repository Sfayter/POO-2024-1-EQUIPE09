package model.beans;

public abstract class Usuario{
	private int id;
	private String nome, email, senha;
	private boolean organizador;
	
	public Usuario(String nome, String email, String senha, boolean organizador) {
		this.nome = nome;
		this.email = email;
		this.senha = senha;
		this.organizador = organizador;
	}
	
	public Usuario() {
		super();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public boolean isOrganizador() {
		return organizador;
	}
	public void setOrganizador(boolean organizador) {
		this.organizador = organizador;
	}
	

}
